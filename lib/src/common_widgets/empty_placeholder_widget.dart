import 'package:aguas_da_borborema/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:aguas_da_borborema/src/common_widgets/primary_button.dart';
import 'package:go_router/go_router.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            PrimaryButton(
              onPressed: () => context.goNamed(AppRoute.home.name),

              text: 'Voltar a Home',
            )
          ],
        ),
      ),
    );
  }
}
