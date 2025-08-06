import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:pluvia/src/features/forecast/data/mongo_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemma/core/chat.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:pluvia/src/features/forecast/domain/model_forecast.dart';
import 'package:pluvia/src/features/forecast/domain/model_full_forecast.dart';
import 'package:pluvia/src/services/contacts_service.dart';
import 'package:pluvia/src/features/forecast/application/forecast_service.dart';

class GemmaLocalService {
  final InferenceChat _chat;
  
  GemmaLocalService(this._chat);
  GemmaLocalService._(this._chat);

  static Future<GemmaLocalService> create(InferenceChat chat) async {
    GemmaLocalService service = GemmaLocalService._(chat);
    await service.addSystemPrompt();
    return service;
  }

  Future<String> _loadContigencePlan(bool isEn) async {
    String fileName = isEn
        ? 'assets/PlanodeContingencia-CampinaGrande2023-Completo-EN.txt'
        : 'assets/PlanodeContingencia-CampinaGrande2023-Completo-PT.txt';
    return await rootBundle.loadString(fileName);
  }

  Future<String> _getContactsAndRisk(bool isEn, PrevisaoAlagamentoCompleta? previsaoCompleta) async {
    final initialText = StringBuffer();
    final contactsAndRisk = StringBuffer();

    // Loads contacts from database
    final contacts = await contactService.getContacts();

    if (previsaoCompleta != null) {
      try {
        for (final c in contacts) {
          contactsAndRisk.writeln('- ${c.name}, ${c.address}: ${c.alagamentoMaisProximo(previsaoCompleta.previsoes)?.name ?? 'No risk'}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching forecast data: $e');
        }
      }
    }
    
    if (contactsAndRisk.isEmpty) {
      initialText.writeln(isEn
          ? 'No saved contacts found.'
          : 'Nenhum contato salvo encontrado.');
    } else {
      initialText.writeln(isEn
          ? 'User contacts (name and address):\n'
          : 'Contatos do usuário (nome e endereço):\n');
    }

    return '$initialText$contactsAndRisk';
  }

  Future<void> addSystemPrompt() async {
    final locale = window.locale;
    final isEn = locale.languageCode == 'en';

    final tomorrow = DateTime.now().add(const Duration(days: 1));
    PrevisaoAlagamentoCompleta? previsaoCompleta;
    try {
      previsaoCompleta = await fetchCurrentPrevisaoCompletaUltimosTresDiasNoUpdate(tomorrow);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching forecast data: $e');
      }
    }

    String savedContactsAndRisk = await _getContactsAndRisk(isEn, previsaoCompleta);
    final previsoesBuffer = StringBuffer();

    if (previsaoCompleta != null) {
      final dateStr = DateFormat(isEn
          ? 'MM/dd/y'
          : 'dd/MM/y').format(previsaoCompleta.dataPrevisao);
      previsoesBuffer.writeln(isEn
          ? 'Forecast for tomorrow ($dateStr):\n'
          : 'Previsão para amanhã ($dateStr):\n');
      for (var previsao in previsaoCompleta.previsoes) {
        final previsaoGravity = StringBuffer();
        switch(previsao.gravidade) {
          case GravidadeAlagamento.baixa:
            previsaoGravity.writeln(isEn ? 'low' : 'baixa');
            break;
          case GravidadeAlagamento.media:
            previsaoGravity.writeln(isEn ? 'medium' : 'média');
            break;
          case GravidadeAlagamento.alta:
            previsaoGravity.writeln(isEn ? 'high' : 'alta');
            break;
        }
      
        previsoesBuffer.writeln(
          isEn
              ? '- Endereço e risco do ponto de alagamento: ${previsao.endereco} | Risco: $previsaoGravity'
              : '- Flood point address and risk: ${previsao.endereco} | Risk: $previsaoGravity',
        );
      }
    }

    if (previsoesBuffer.isEmpty) {
      previsoesBuffer.writeln(isEn
          ? 'No flood predictions available for tomorrow.'
          : 'Nenhuma previsão de alagamento disponível para amanhã.');
    }

    final systemPrompt = StringBuffer();

    String contigencePlan = await _loadContigencePlan(isEn);
    if (isEn) {
      systemPrompt.writeln(_promptEn(contigencePlan, savedContactsAndRisk, previsoesBuffer.toString()));
    } else {
      systemPrompt.writeln(_promptPt(contigencePlan, savedContactsAndRisk, previsoesBuffer.toString()));
    }

    await _chat.addQueryChunk(
      Message(text: '$systemPrompt', isUser: false),
    );
  }

  Future<void> addQueryChunk(Message message) => _chat.addQueryChunk(message);

  Stream<String> processMessageAsync(Message message) async* {
    await _chat.addQueryChunk(message);
    yield* _chat.generateChatResponseAsync();
  }

  String _promptPt(String contigencePlan, String savedContactsAndRisk, String previsoes) {
    return '''Você é um assistente especializado em assistência frente a desastres naturais, especialmente enchentes e alagamentos em zonas urbanas.
Use as instruções do plano de contigência da cidade de Campina Grande como referência para auxiliar a população.
Atenda a solicitação do usuário para auxiliá-lo.
Se o usuário perguntar sobre a previsão de chuva atual utilize os dados das previsões que você recebeu, retire informações da previsão apenas dos dados recebidos.
Se o usuário perguntar sober a previsão de chuva atual informe se algum de algum dos contatos salvos do usuário está em risco e qual o nível de risco, informe isso apenas baseando se nas informações recebidas e se houver algum em risco.
Responda de modo objetivo a fim de ajudar o usuário.
Se houver imagem, processe-a para atender a solicitação do usuário.

Plano de contigência:
$contigencePlan

Previsões de alagamento:
$previsoes

Contatos salvos e risco associado:
$savedContactsAndRisk''';
  }

  String _promptEn(String contigencePlan, String savedContactsAndRisk, String previsoes) {
    return '''You are an assistant specialized in disaster response, particularly floods and inundations in urban areas.
Use the contingency plan of the city of Campina Grande as a reference to assist the population.
Respond to the user's request in order to help them.
If the user asks about the current rain forecast, use only the forecast data you received; extract information solely from the data provided.
If the user asks about the current rain forecast, inform whether any of the user's saved contacts are at risk and what the level of risk is. Provide this information only based on the data received and only if any are at risk.
Respond objectively in order to assist the user.
If there is an image, process the image to attend the user's request.

Contingency Plan:
$contigencePlan

Flood Predictions:
$previsoes

Saved contacts and associated risk:
$savedContactsAndRisk''';
  }
}