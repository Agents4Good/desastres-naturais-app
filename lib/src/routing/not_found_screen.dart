import 'package:flutter/material.dart';
import 'package:pluvia/src/common_widgets/empty_placeholder_widget.dart';
import 'package:pluvia/l10n/app_localizations.dart';

/// Tela exibida quando a rota não é encontrada (404)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(),
      body: EmptyPlaceholderWidget(
        message: l10n.error404,
      ),
    );
  }
}
