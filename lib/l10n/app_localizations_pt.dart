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
  String get loadingModel => 'Carregando o modelo';

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
