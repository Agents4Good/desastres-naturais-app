// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Águas da Borborema';

  @override
  String get navHome => 'Home';

  @override
  String get navChat => 'Chat';

  @override
  String get navMap => 'Mapa';

  @override
  String get navForecast => 'Previsões';

  @override
  String get navSettings => 'Configurações';

  @override
  String get navContacts => 'Contatos';

  @override
  String get notificationsScreenTitle => 'Previsões';

  @override
  String get severityHigh => 'Gravidade Alta';

  @override
  String get severityMedium => 'Gravidade Média';

  @override
  String get severityLow => 'Gravidade Baixa';

  @override
  String noStreetsWithSeverity(Object severity) {
    return '- Nenhuma rua com $severity';
  }

  @override
  String forecastItemTitle(Object date) {
    return 'Previsão - $date';
  }

  @override
  String executionDate(Object date) {
    return 'Data de execução\n$date';
  }

  @override
  String get dateFormatUpToDay => 'dd/MM/y';

  @override
  String get dateFormatFull => 'dd/MM/yyyy HH:mm:ss';

  @override
  String notificationsError(Object error) {
    return 'Erro ao carregar notificações: $error';
  }

  @override
  String get error404 => '404 - Página não encontrada!';

  @override
  String get error501 => '501 - Ainda não implementado!';

  @override
  String get buttonReturnHome => 'Voltar a Home';

  @override
  String get notificationChannelName => 'Notificações importantes';

  @override
  String get notificationChannelDescription => 'Este canal é usado para notificações importantes.';

  @override
  String get notificationTestTitle => 'Notificação de Teste';

  @override
  String get notificationTestBody => 'Esta é uma notificação local de teste.';

  @override
  String get imageSupportEnabled => 'Suporte a imagem ativado';

  @override
  String get selectModel => 'Selecione um modelo';

  @override
  String get loadingModel => 'Carregando o modelo';

  @override
  String get downloadModelAppBarTitle => 'Baixar modelo';

  @override
  String get deleteModelConfirmation => 'Deletar o modelo?';

  @override
  String get deleteModelConfirmationDesc1 => 'Tem certeza que quer deletar o modelo?';

  @override
  String get deleteModelConfirmationDesc2 => 'Você terá que baixá-lo novamente se quiser usá-lo novamente.';

  @override
  String downloadModelTitle(String modelName) {
    return 'Baixar modelo $modelName';
  }

  @override
  String get hfTokenRequired => 'Por favor, defina o seu token primeiro.';

  @override
  String get hfTokenFillInLabel => 'Preencha o Token de Acesso do HuggingFace';

  @override
  String get hfTokenFillInHint => 'Preencha aqui seu token de acesso do Hugging Face';

  @override
  String get hfTokenSuccessMessage => 'Token de acesso salvo com sucesso!';

  @override
  String get hfCreateTokenHelp => 'Para criar um token de acesso, por favor, visite os ajustes de sua conta do HuggingFace em ';

  @override
  String get hfVerifyTokenPerms => '. Verifique se o seu token possui acesso de leitura ao repositório.';

  @override
  String get genericConfirm => 'Sim';

  @override
  String get genericDeny => 'Não';

  @override
  String get modelDelete => 'Deletar';

  @override
  String get modelDownload => 'Baixar';

  @override
  String get modelDownloadFailure => 'Falha ao baixar o modelo.';

  @override
  String modelDownloadProgress(double progress) {
    return 'Progresso do Download: ${(progress * 100).toStringAsFixed(1)}%';
  }

  @override
  String get modelLicense => 'Licença: ';

  @override
  String get useThisModel => 'Usar este modelo no Chat';

  @override
  String get imageSupportInfoTitle => 'O modelo suporta imagens';

  @override
  String get imageSupportInfoBody => 'Uso o botão 📷 para enviar imagens';

  @override
  String errorBannerMessage(Object errorMessage) {
    return '$errorMessage';
  }

  @override
  String get buttonToggleView => 'Alternar visualização';

  @override
  String get homeWelcomeTitle => 'Bem-vindo ao Águas da Borborema';

  @override
  String get homeWelcomeSubtitle => 'Explore nossa solução de assistência à eventos de catástrofes naturais';

  @override
  String get homeChatSubtitle => 'Navegue por uma gama de modelos que rodam localmente no seu dispositivo!';

  @override
  String get homeMapSubtitle => 'Visualize no mapa as novas atualizações de previsões!';

  @override
  String get homeForecastSubtitle => 'Cheque as últimas previsões!';

  @override
  String get homeContactsSubtitle => 'Acesse sua lista de contatos.';

  @override
  String get homeSettingsSubtitle => 'Acesse as configurações de modelos, casa e contatos salvos.';

  @override
  String get contactsTitle => 'Contatos Salvos';

  @override
  String get contactsEmptyMessage => 'Adicione um novo contato.';

  @override
  String get contactsEdit => 'Editar';

  @override
  String get contactsDelete => 'Excluir';

  @override
  String get deleteContactConfirmation => 'Você tem certeza de que deseja excluir este contato?';

  @override
  String get buttonCancel => 'Cancelar';

  @override
  String get buttonSave => 'Salvar';

  @override
  String get updateContactLabelName => 'Nome';

  @override
  String get updateContactLabelAddress => 'Endereço';

  @override
  String get addContactLabelName => 'Nome';

  @override
  String get addContactHintLocation => 'Localização';

  @override
  String get highlightedFloodPoints => 'Os pontos em destaque sofreram alagamentos!';

  @override
  String get imageSelectionNotSupportedWeb => 'Seleção de imagem ainda não é suportada na web';

  @override
  String errorSelectingImage(Object error) {
    return 'Erro na seleção da imagem: $error';
  }

  @override
  String get addImageTooltip => 'Adicionar imagem';

  @override
  String get addDescriptionToImage => 'Adicionar descrição à imagem...';

  @override
  String get sendMessage => 'Enviar mensagem';

  @override
  String get imageLabel => 'Imagem';

  @override
  String get removeImageTooltip => 'Remover imagem';
}
