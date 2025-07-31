// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Waters of Borborema';

  @override
  String get navHome => 'Home';

  @override
  String get navChat => 'Chat';

  @override
  String get navMap => 'Map';

  @override
  String get navForecast => 'Forecasts';

  @override
  String get navSettings => 'Settings';

  @override
  String get navContacts => 'Contacts';

  @override
  String get notificationsScreenTitle => 'Forecasts';

  @override
  String get severityHigh => 'High Severity';

  @override
  String get severityMedium => 'Medium Severity';

  @override
  String get severityLow => 'Low Severity';

  @override
  String noStreetsWithSeverity(Object severity) {
    return '- No streets with $severity';
  }

  @override
  String forecastItemTitle(Object date) {
    return 'Forecast - $date';
  }

  @override
  String executionDate(Object date) {
    return 'Execution Date\n$date';
  }

  @override
  String notificationsError(Object error) {
    return 'Error loading notifications: $error';
  }

  @override
  String get error404 => '404 - Page not found!';

  @override
  String get error501 => '501 - Not implemented yet!';

  @override
  String get buttonReturnHome => 'Return to Home';

  @override
  String get notificationChannelName => 'Important Notifications';

  @override
  String get notificationChannelDescription => 'This channel is used for important notifications.';

  @override
  String get notificationTestTitle => 'Test Notification';

  @override
  String get notificationTestBody => 'This is a local test notification.';

  @override
  String get imageSupportEnabled => 'Image support enabled';

  @override
  String get loadingModel => 'Loading model';

  @override
  String get imageSupportInfoTitle => 'Model supports images';

  @override
  String get imageSupportInfoBody => 'Use the 📷 button to send images';

  @override
  String errorBannerMessage(Object errorMessage) {
    return '$errorMessage';
  }
}
