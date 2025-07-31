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
}
