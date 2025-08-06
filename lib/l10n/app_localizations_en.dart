// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PluvIA';

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
  String get dateFormatUpToDay => 'MM/dd/y';

  @override
  String get dateFormatFull => 'MM/dd/yyyy HH:mm:ss';

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
  String get selectModel => 'Select a model';

  @override
  String get loadingModel => 'Loading model';

  @override
  String get downloadModelAppBarTitle => 'Download model';

  @override
  String get deleteModelConfirmation => 'Delete model?';

  @override
  String downloadModelTitle(String modelName) {
    return 'Download model $modelName';
  }

  @override
  String get hfTokenRequired => 'Please set your token first.';

  @override
  String get hfTokenFillInLabel => 'Fill in the HuggingFace Access Token';

  @override
  String get hfTokenFillInHint => 'Fill in your Hugging Face access token here';

  @override
  String get hfTokenSuccessMessage => 'Access token saved successfully!';

  @override
  String get hfCreateTokenHelp => 'To create an access token, please visit your HuggingFace account settings at ';

  @override
  String get hfVerifyTokenPerms => '. Make sure your token has read access to the repository.';

  @override
  String get genericConfirm => 'Yes';

  @override
  String get genericDeny => 'No';

  @override
  String get modelDelete => 'Delete';

  @override
  String get modelDownload => 'Download';

  @override
  String get modelDownloadFailure => 'Failed to download the model.';

  @override
  String modelDownloadProgress(double progress) {
    return 'Download Progress: ${(progress * 100).toStringAsFixed(1)}%';
  }

  @override
  String get modelLicense => 'License: ';

  @override
  String get useThisModel => 'Use this model in Chat';

  @override
  String get imageSupportInfoTitle => 'Model supports images';

  @override
  String get imageSupportInfoBody => 'Use the 🖼️ button to send images';

  @override
  String errorBannerMessage(Object errorMessage) {
    return '$errorMessage';
  }

  @override
  String get buttonToggleView => 'Toggle view';

  @override
  String get homeWelcomeTitle => 'Welcome to PluvIA';

  @override
  String get homeWelcomeSubtitle => 'Explore our solution for natural disaster assistance';

  @override
  String get homeChatSubtitle => 'Browse a range of models running locally on your device!';

  @override
  String get homeMapSubtitle => 'See new forecast updates on the map!';

  @override
  String get homeForecastSubtitle => 'Check out the latest forecasts!';

  @override
  String get errorLoadingForecast => 'Error loading forecasts';

  @override
  String get homeContactsSubtitle => 'Access your contacts list.';

  @override
  String get homeSettingsSubtitle => 'Go to model, home & contacts settings.';

  @override
  String get contactsTitle => 'Saved Contacts';

  @override
  String get contactsEmptyMessage => 'Add a new contact.';

  @override
  String get contactsEdit => 'Edit';

  @override
  String get contactsDelete => 'Delete';

  @override
  String get deleteContactConfirmation => 'Are you sure you want to delete this contact?';


  @override
  String get deleteModelConfirmationDesc1 => 'Are you sure you want to delete this model?';

  @override
  String get deleteModelConfirmationDesc2 => 'You will need to download it again if you want to use it again.';

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get buttonSave => 'Save';

  @override
  String get updateContactLabelName => 'Name';

  @override
  String get updateContactLabelAddress => 'Address';

  @override
  String get addContactLabelName => 'Name';

  @override
  String get addContactHintLocation => 'Location';

  @override
  String get highlightedFloodPoints => 'Highlighted points suffered flooding!';

  @override
  String get mapPrevisionDate => 'Forecast Date';

  @override
  String get imageSelectionNotSupportedWeb => 'Image selection is not yet supported on the web';

  @override
  String errorSelectingImage(Object error) {
    return 'Error selecting image: $error';
  }

  @override
  String get addImageTooltip => 'Add image';

  @override
  String get addDescriptionToImage => 'Add description to the image...';

  @override
  String get sendMessage => 'Send message';

  @override
  String get imageLabel => 'Image';

  @override
  String get removeImageTooltip => 'Remove image';
}
