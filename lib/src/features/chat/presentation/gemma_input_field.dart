import 'dart:async';
import 'dart:ui';

import 'package:pluvia/src/features/chat/presentation/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemma/core/chat.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:pluvia/src/services/gemma_service.dart';

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

  @override
  void initState() {
    super.initState();
    // _gemma = GemmaLocalService(widget.chat!);
    GemmaLocalService.create(widget.chat!).then((service) {
      _gemma = service;
      _processMessages();
    });
  }

  void _processMessages() {
    final locale = window.locale;
    final isEn = locale.languageCode == 'en';

    final originalMessage = widget.messages.last;
    final messageText = StringBuffer();
    messageText.writeln(isEn
        ? 'User request:\n${originalMessage.text}'
        : 'Solicitação do usuário:\n${originalMessage.text}');

    final messageWithContext = Message(
          isUser: originalMessage.isUser,
          text: messageText.toString(),
          imageBytes: originalMessage.imageBytes);
    
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