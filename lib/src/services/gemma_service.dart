import 'dart:ui';
import 'package:flutter_gemma/core/chat.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:aguas_da_borborema/src/services/contacts_service.dart';

/// Serviço local responsável por inserir um prompt inicial bilíngue
class GemmaLocalService {
  final InferenceChat _chat;
  bool _hasAddedPrompt = false;

  /// Cria o serviço recebendo apenas o InferenceChat.
  GemmaLocalService(this._chat);

  /// Adiciona o prompt inicial ao histórico apenas uma vez,
  /// escolhendo o idioma com base no Locale do dispositivo e
  /// incluindo dados de contatos (nome e endereço).
  Future<void> addQueryChunk(Message message) async {
    if (!_hasAddedPrompt) {
      // Obtém contatos salvo no banco
      final contacts = await contactService.getContacts();
      final locale = window.locale;
      final isEn = locale.languageCode == 'en';

      // Monta lista de contatos
      final buffer = StringBuffer();
      buffer.writeln(isEn
          ? 'User contacts (name and address):'
          : 'Contatos do usuário (nome e endereço):');
      for (final c in contacts) {
        buffer.writeln(
            isEn ? '- ${c.name}, ${c.address}' : '- ${c.name}, ${c.address}');
      }

      // Adiciona instruções de sistema
      final systemPrompt = isEn ? _promptEn : _promptPt;
      await _chat.addQueryChunk(
        Message(text: '${buffer.toString()}\n$systemPrompt', isUser: false),
      );
      _hasAddedPrompt = true;
    }
    await _chat.addQueryChunk(message);
  }

  /// Processa as mensagens chamando o prompt e retornando o stream de tokens.
  Stream<String> processMessageAsync(Message message) async* {
    await addQueryChunk(message);
    yield* _chat.generateChatResponseAsync();
  }

  static const String _promptPt = '''
VOCÊ É UM ASSISTENTE VIRTUAL ESPECIALISTA EM METEOROLOGIA E PREVENÇÃO DE DESASTRES NATURAIS, ESPECIALMENTE ENCHENTES.
INCLUA ORIENTAÇÕES DE SEGURANÇA:
- PROTEJA-SE: EVITE CONTATO COM A ÁGUA DA ENCHENTE, POIS PODE ESTAR CONTAMINADA.
- SIGA AS ORIENTAÇÕES: DESLIGUE A ENERGIA, FECHE O REGISTRO DE ÁGUA E GÁS E SIGA AS INSTRUÇÕES DAS AUTORIDADES.
- EVACUE SE NECESSÁRIO: SAIA DE CASA E PROCURE UM LOCAL SEGURO.
IMPORTANTE: SUAS RESPOSTAS NÃO DEVEM ULTRAPASSAR 7 LINHAS.
''';

  static const String _promptEn = '''
YOU ARE A VIRTUAL ASSISTANT SPECIALIZED IN METEOROLOGY AND NATURAL DISASTER PREVENTION, ESPECIALLY FLOODS.
INCLUDE SAFETY GUIDANCE:
- STAY PROTECTED: AVOID CONTACT WITH FLOODWATER, WHICH MAY BE CONTAMINATED.
- FOLLOW GUIDANCE: TURN OFF ELECTRICITY, CLOSE WATER AND GAS VALVES, AND FOLLOW AUTHORITIES' INSTRUCTIONS.
- EVACUATE IF NEEDED: LEAVE YOUR HOME AND SEEK A SAFE LOCATION.
IMPORTANT: YOUR RESPONSES MUST NOT EXCEED 7 LINES.
''';
}
