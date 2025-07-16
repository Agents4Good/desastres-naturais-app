import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gemma/core/chat.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:aguas_da_borborema/chat_message.dart';
import 'package:aguas_da_borborema/services/gemma_service.dart';
import 'package:flutter/services.dart' show rootBundle;

class GemmaInputField extends StatefulWidget {
  const GemmaInputField({
    super.key,
    required this.messages,
    required this.streamHandler,
    required this.errorHandler,
    this.chat,
  });

  final InferenceChat? chat;
  final List<Message> messages;
  final ValueChanged<Message> streamHandler;
  final ValueChanged<String> errorHandler;

  @override
  GemmaInputFieldState createState() => GemmaInputFieldState();
}

class GemmaInputFieldState extends State<GemmaInputField> {
  GemmaLocalService? _gemma;
  StreamSubscription<String?>? _subscription;
  var _message = const Message(text: '');
  String? planoContingencia;

  @override
  void initState() {
    super.initState();
    _loadPlano().then((_) {
      _gemma = GemmaLocalService(widget.chat!);
      _processMessages();
    });
  }

  Future<void> _loadPlano() async {
    planoContingencia = await rootBundle.loadString('assets/PlanodeContingencia-CampinaGrande2023.txt');
  }

  void _processMessages() {
    final originalMessage = widget.messages.last;

    final messageWithContext = Message(
          isUser: originalMessage.isUser,
          text: '''
            Abaixo está o plano de contigência da cidade de Campina Grande. O seu objetivo é auxiliar
            o usuário de acordo com o plano da cidade:
            $planoContingencia

            Pergunta:
            ${originalMessage.text}
            ''',
      );
    _subscription = _gemma?.processMessageAsync(messageWithContext).listen(
      (String token) {
        if (!mounted) return;
        setState(() {
          _message = Message(text: '${_message.text}$token');
        });
      },
      onDone: () {
        if (!mounted) return;
        if (_message.text.isEmpty) {
          _message = const Message(text: '...');
        }
        widget.streamHandler(_message);
        _subscription?.cancel();
      },
      onError: (error) {
        if (!mounted) return;
        debugPrint('Error: $error');
        if (_message.text.isEmpty) {
          _message = const Message(text: '...');
        }
        widget.streamHandler(_message);
        widget.errorHandler(error.toString());
        _subscription?.cancel();
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ChatMessageWidget(message: _message),
    );
  }
}
