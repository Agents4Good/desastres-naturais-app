import 'package:pluvia/l10n/app_localizations.dart';
import 'package:pluvia/src/constants/available_models.dart';
import 'package:pluvia/src/features/chat/presentation/chat_screen.dart';
import 'package:pluvia/src/services/model_download_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ModelDownloadScreen extends StatefulWidget {
  final Model model;

  const ModelDownloadScreen({super.key, required this.model});

  @override
  State<ModelDownloadScreen> createState() => _ModelDownloadScreenState();
}

class _ModelDownloadScreenState extends State<ModelDownloadScreen> {
  late ModelDownloadService _downloadService;
  bool needToDownload = true;
  double _progress = 0.0; // Track download progress
  String _token = ''; // Store the token
  final TextEditingController _tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _downloadService = ModelDownloadService(
      modelUrl: widget.model.url,
      modelFilename: widget.model.filename,
      licenseUrl: widget.model.licenseUrl,
    );
    _initialize();
  }

  Future<void> _initialize() async {
    _token = await _downloadService.loadToken() ?? '';
    _tokenController.text = _token;
    needToDownload = !(await _downloadService.checkModelExistence(_token));
    setState(() {});
  }

  Future<void> _saveToken(String token) async {
    await _downloadService.saveToken(token);
    await _initialize();
  }

  Future<void> _downloadModel() async {
    final l10n = AppLocalizations.of(context)!;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (widget.model.needsAuth && _token.isEmpty) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(l10n.hfTokenRequired)),
      );
      return;
    }

    try {
      await _downloadService.downloadModel(
        token:
            widget.model.needsAuth ? _token : '', // Pass token only if needed
        onProgress: (progress) {
          setState(() {
            _progress = progress;
          });
        },
      );
      setState(() {
        needToDownload = false;
      });
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(l10n.modelDownloadFailure)),
      );
    } finally {
      if (mounted) {
        setState(() {
          _progress = 0.0;
        });
      }
    }
  }

  Future<void> _deleteModel() async {
    await _downloadService.deleteModel();
    setState(() {
      needToDownload = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.downloadModelAppBarTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.downloadModelTitle(widget.model.displayName),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (widget
                .model.needsAuth) // Show token input only if auth is required
              TextField(
                controller: _tokenController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: l10n.hfTokenFillInLabel,
                  hintText: l10n.hfTokenFillInHint,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () async {
                      final token = _tokenController.text.trim();
                      if (token.isNotEmpty) {
                        await _saveToken(token);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.hfTokenSuccessMessage),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            if (widget.model.needsAuth)
              RichText(
                text: TextSpan(
                  text:
                      l10n.hfCreateTokenHelp,
                  children: [
                    TextSpan(
                      text: 'https://huggingface.co/settings/tokens',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(
                              'https://huggingface.co/settings/tokens'));
                        },
                    ),
                    TextSpan(
                      text:
                          l10n.hfVerifyTokenPerms,
                    ),
                  ],
                ),
              ),
            if (widget.model.licenseUrl.isNotEmpty)
              RichText(
                text: TextSpan(
                  text: l10n.modelLicense,
                  children: [
                    TextSpan(
                      text: widget.model.licenseUrl,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(widget.model.licenseUrl));
                        },
                    ),
                  ],
                ),
              ),
            Center(
              child: _progress > 0.0
                  ? Column(
                      children: [
                        Text(l10n.modelDownloadProgress(_progress)),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(value: _progress),
                      ],
                    )
                  : ElevatedButton(
                      onPressed:
                          !needToDownload ? () => showDialog<String>(
            context: context,
            builder:
              (BuildContext context) => AlertDialog(
                        title: Text(l10n.deleteModelConfirmation),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(l10n.deleteModelConfirmationDesc1),
                              Text(l10n.deleteModelConfirmationDesc2),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(l10n.genericConfirm),
                            onPressed: _deleteModel,
                          ),
                          TextButton(
                            child: Text(l10n.genericDeny),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )
                      ) : _downloadModel,
                      child: Text(!needToDownload ? l10n.modelDelete : l10n.modelDownload),
                    ),
            ),
            const Spacer(),
            if (!needToDownload)
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute<void>(builder: (context) {
                        return ChatScreen(model: widget.model);
                      }));
                    },
                    child: Text(l10n.useThisModel),
                  ),
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}