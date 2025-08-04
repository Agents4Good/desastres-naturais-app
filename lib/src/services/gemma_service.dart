import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_gemma/core/chat.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:aguas_da_borborema/src/services/contacts_service.dart';

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

  Future<String> _getContactsAndRisk(bool isEn) async {
    final contactsAndRisk = StringBuffer();

    // Loads contacts from database
    final contacts = await contactService.getContacts();
    contactsAndRisk.writeln(isEn
        ? 'User contacts (name and address):'
        : 'Contatos do usuário (nome e endereço):');
    for (final c in contacts) {
      contactsAndRisk.writeln('- ${c.name}, ${c.address}');
    }
    return '$contactsAndRisk';
  }

  Future<void> addSystemPrompt() async {
    final locale = window.locale;
    final isEn = locale.languageCode == 'en';

    String savedContactsAndRisk = await _getContactsAndRisk(isEn);
  

    final systemPrompt = StringBuffer();

    String contigencePlan = await _loadContigencePlan(isEn);
    if (isEn) {
      systemPrompt.writeln(_promptEn(contigencePlan, savedContactsAndRisk));
    } else {
      systemPrompt.writeln(_promptPt(contigencePlan, savedContactsAndRisk));
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

  String _promptPt(String contigencePlan, String savedContactsAndRisk) {
    return '''Você é um assistente especializado em assistência frente a desastres naturais, especialmente enchentes e alagamentos em zonas urbanas.
Use as instruções do plano de contigência da cidade de Campina Grande como referência para auxiliar a população.
Atenda a solicitação do usuário para auxiliá-lo.
Se o usuário perguntar sobre a previsão de chuva atual utilize os dados das previsões que você recebeu, retire informações da previsão apenas dos dados recebidos.
Se o usuário perguntar sober a previsão de chuva atual informe se algum de algum dos contatos salvos do usuário está em risco e qual o nível de risco, informe isso apenas baseando se nas informações recebidas e se houver algum em risco.
Responda de modo objetivo a fim de ajudar o usuário.

Plano de contigência:
$contigencePlan

Contatos salvos e risco associado:
$savedContactsAndRisk''';
  }

  String _promptEn(String contigencePlan, String savedContactsAndRisk) {
    return '''You are an assistant specialized in disaster response, particularly floods and inundations in urban areas.
Use the contingency plan of the city of Campina Grande as a reference to assist the population.
Respond to the user's request in order to help them.
If the user asks about the current rain forecast, use only the forecast data you received; extract information solely from the data provided.
If the user asks about the current rain forecast, inform whether any of the user's saved contacts are at risk and what the level of risk is. Provide this information only based on the data received and only if any are at risk.
Respond objectively in order to assist the user.

Contingency Plan:
$contigencePlan

Saved contacts and associated risk:
$savedContactsAndRisk''';
  }
}