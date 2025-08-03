import 'package:aguas_da_borborema/src/constants/available_models.dart';
import 'package:aguas_da_borborema/src/features/chat/presentation/chat_screen.dart';
import 'package:aguas_da_borborema/src/services/model_download_service.dart';
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
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (widget.model.needsAuth && _token.isEmpty) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Por favor, defina o seu token primeiro.')),
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
        const SnackBar(content: Text('Falha ao baixar o modelo.')),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baixar Modelo'),
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
              'Baixar Modelo ${widget.model.name}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (widget
                .model.needsAuth) // Show token input only if auth is required
              TextField(
                controller: _tokenController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Preencha o Token de Acesso do HuggingFace',
                  hintText: 'Preencha aqui seu token de acesso do Hugging Face',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () async {
                      final token = _tokenController.text.trim();
                      if (token.isNotEmpty) {
                        await _saveToken(token);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Token de acesso salvo com sucesso!'),
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
                      'Para criar um token de acesso, por favor, visite os ajustes de sua conta do huggingface em ',
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
                    const TextSpan(
                      text:
                          '. Verifique se o seu token possui acesso de leitura ao repositório.',
                    ),
                  ],
                ),
              ),
            if (widget.model.licenseUrl.isNotEmpty)
              RichText(
                text: TextSpan(
                  text: 'Licença: ',
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
                        Text(
                            'Progresso do Download: ${(_progress * 100).toStringAsFixed(1)}%'),
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
                        title: const Text('Deletar Modelo?'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Tem certeza que quer deletar o modelo?'),
                              Text('Você terá que baixá-lo novamente se quiser usá-lo novamente.'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Sim'),
                            onPressed: _deleteModel,
                          ),
                          TextButton(
                            child: const Text('Não'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )
                      ) : _downloadModel,
                      child: Text(!needToDownload ? 'Deletar' : 'Baixar'),
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
                    child: const Text('Usar este modelo no Chat'),
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