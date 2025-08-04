import 'package:flutter/material.dart';
import 'package:aguas_da_borborema/src/common_widgets/empty_placeholder_widget.dart';
import 'package:aguas_da_borborema/l10n/app_localizations.dart';

/// Simple not implemented screen used for unimplemented routes
class NotImplementedScreen extends StatelessWidget {
  const NotImplementedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: EmptyPlaceholderWidget(
        message: l10n.error501,  // usa a chave do arb
      ),
    );
  }
}
