import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemma/core/chat.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:aguas_da_borborema/src/features/chat/presentation/chat_widget.dart';
import 'package:aguas_da_borborema/src/common_widgets/loading_widget.dart';
import 'package:aguas_da_borborema/src/constants/available_models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:aguas_da_borborema/src/features/model_management/presentation/select/model_selection_screen.dart';
import 'package:aguas_da_borborema/l10n/app_localizations.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.model = Model.gemma3Gpu_1B});

  final Model model;

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _gemma = FlutterGemmaPlugin.instance;
  InferenceChat? chat;
  final _messages = <Message>[];
  bool _isModelInitialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeModel();
  }

  @override
  void dispose() {
    super.dispose();
    _gemma.modelManager.deleteModel();
  }

  Future<void> _initializeModel() async {
    if (!await _gemma.modelManager.isModelInstalled) {
      var path = widget.model.url;
      if (!kIsWeb) {
        if (widget.model.localModel) {
          path = '${(await getExternalStorageDirectory())?.path}/${widget.model.filename}';
        } else {
          path = '${(await getApplicationDocumentsDirectory()).path}/${widget.model.filename}';
        }
      }
      await _gemma.modelManager.setModelPath(path);
    }

    final model = await _gemma.createModel(
      modelType: super.widget.model.modelType,
      preferredBackend: super.widget.model.preferredBackend,
      maxTokens: 4096,
      supportImage: widget.model.supportImage, // Pass image support
      maxNumImages: widget.model.maxNumImages, // Maximum 4 images for multimodal models
    );

    chat = await model.createChat(
      temperature: widget.model.temperature,
      randomSeed: 1,
      topK: widget.model.topK,
      topP: widget.model.topP,
      tokenBuffer: 256,
      supportImage: widget.model.supportImage,
    );

    setState(() {
      _isModelInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF0b2351),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0b2351),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const ModelSelectionScreen(),
              ),
              (route) => false,
            );
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.appTitle,
              style: const TextStyle(fontSize: 18),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            if (chat?.supportsImages == true)
              Text(
                l10n.imageSupportEnabled,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.normal,
                ),
              ),
          ],
        ),
        actions: [
          if (chat?.supportsImages == true)
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.image,
                color: Colors.green,
                size: 20,
              ),
            ),
        ],
      ),
      body: Stack(children: [
        Center(
          child: Image.asset(
            'assets/gota_complexa_new_bg.png',
            width: 300,
            height: 300,
          ),
        ),
        _isModelInitialized
            ? Column(children: [
                if (_error != null)
                  _buildErrorBanner(l10n.errorBannerMessage(_error!)),
                if (chat?.supportsImages == true && _messages.isEmpty)
                  _buildImageSupportInfo(l10n),
                Expanded(
                  child: ChatListWidget(
                    chat: chat,
                    gemmaHandler: (message) {
                      setState(() => _messages.add(message));
                    },
                    humanHandler: (message) {
                      setState(() {
                        _error = null;
                        _messages.add(message);
                      });
                    },
                    errorHandler: (err) {
                      setState(() => _error = err);
                    },
                    messages: _messages,
                  ),
                )
              ])
            : LoadingWidget(message: l10n.loadingModel),
      ]),
    );
  }

  Widget _buildErrorBanner(String errorMessage) {
    return Container(
      width: double.infinity,
      color: Colors.red,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildImageSupportInfo(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1a3a5c),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.imageSupportInfoTitle,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  l10n.imageSupportInfoBody,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
