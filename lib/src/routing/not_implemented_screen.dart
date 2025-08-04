import 'package:flutter/material.dart';
import 'package:aguas_da_borborema/src/common_widgets/empty_placeholder_widget.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotImplementedScreen extends StatelessWidget {
  const NotImplementedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EmptyPlaceholderWidget(
        message: '501 - Ainda não implementado!',
      ),
    );
  }
}