import 'package:pluvia/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemma/pigeon.g.dart';
import 'package:pluvia/src/features/chat/presentation/chat_screen.dart';
import 'package:pluvia/src/features/model_management/presentation/download/model_download_screen.dart';
import 'package:pluvia/src/constants/available_models.dart';
import 'dart:io' as io;

class ModelSelectionScreen extends StatelessWidget {
  const ModelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final models = Model.values.where((model) {
      if (model.localModel) {
        // return kIsWeb;
        return true;
      }
      if (!kIsWeb) return true;
      return model.preferredBackend == PreferredBackend.gpu && !model.needsAuth;
    }).toList();
    return Scaffold(
      backgroundColor: const Color(0xFF0b2351),
      appBar: AppBar(
        title: Text(l10n.selectModel),
        backgroundColor: const Color(0xFF0b2351),
      ),
      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(models[index].displayName),
            onTap: () {
              // Navigate to download screen (non-web) or chat screen (web)
              
              if (models[index].localModel) {
                var modelPath = models[index].url;

                // if (io.File(modelPath).existsSync()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => ChatScreen(
                        model: models[index],
                      ),
                    ),
                  );  
                // } else {
                //   final scaffold = ScaffoldMessenger.of(context);
                //   scaffold.showSnackBar(
                //     SnackBar(
                //       content: Text('This model was not found in the expected path [Path: $modelPath]'),
                //       action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
                //       duration: const Duration(seconds: 10),
                //     ),
                //   );
                // }

              }
              if (!kIsWeb) {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => ModelDownloadScreen(
                      model: models[index],
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => ChatScreen(
                      model: models[index],
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
