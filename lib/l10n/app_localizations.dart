import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Waters of Borborema'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get navChat;

  /// No description provided for @navMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get navMap;

  /// No description provided for @navForecast.
  ///
  /// In en, this message translates to:
  /// **'Forecasts'**
  String get navForecast;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navContacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get navContacts;

  /// No description provided for @notificationsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Forecasts'**
  String get notificationsScreenTitle;

  /// No description provided for @severityHigh.
  ///
  /// In en, this message translates to:
  /// **'High Severity'**
  String get severityHigh;

  /// No description provided for @severityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium Severity'**
  String get severityMedium;

  /// No description provided for @severityLow.
  ///
  /// In en, this message translates to:
  /// **'Low Severity'**
  String get severityLow;

  /// No description provided for @noStreetsWithSeverity.
  ///
  /// In en, this message translates to:
  /// **'- No streets with {severity}'**
  String noStreetsWithSeverity(Object severity);

  /// No description provided for @forecastItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Forecast - {date}'**
  String forecastItemTitle(Object date);

  /// No description provided for @executionDate.
  ///
  /// In en, this message translates to:
  /// **'Execution Date\n{date}'**
  String executionDate(Object date);

  String get dateFormatUpToDay;

  String get dateFormatFull;

  /// No description provided for @notificationsError.
  ///
  /// In en, this message translates to:
  /// **'Error loading notifications: {error}'**
  String notificationsError(Object error);

  /// No description provided for @error404.
  ///
  /// In en, this message translates to:
  /// **'404 - Page not found!'**
  String get error404;

  /// No description provided for @error501.
  ///
  /// In en, this message translates to:
  /// **'501 - Not implemented yet!'**
  String get error501;

  /// No description provided for @buttonReturnHome.
  ///
  /// In en, this message translates to:
  /// **'Return to Home'**
  String get buttonReturnHome;

  /// No description provided for @notificationChannelName.
  ///
  /// In en, this message translates to:
  /// **'Important Notifications'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'This channel is used for important notifications.'**
  String get notificationChannelDescription;

  /// No description provided for @notificationTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Test Notification'**
  String get notificationTestTitle;

  /// No description provided for @notificationTestBody.
  ///
  /// In en, this message translates to:
  /// **'This is a local test notification.'**
  String get notificationTestBody;

  /// No description provided for @imageSupportEnabled.
  ///
  /// In en, this message translates to:
  /// **'Image support enabled'**
  String get imageSupportEnabled;

  /// No description provided for @selectModel.
  /// 
  /// In en, this message translates to:
  /// **'Select a model'**
  String get selectModel;

  /// No description provided for @loadingModel.
  ///
  /// In en, this message translates to:
  /// **'Loading model'**
  String get loadingModel;

  String get downloadModelAppBarTitle;

  String get deleteModelConfirmation;

  String get deleteModelConfirmationDesc1;

  String get deleteModelConfirmationDesc2;

  // Download model title
  String downloadModelTitle(String modelName);

  String get hfTokenRequired;

  String get hfTokenFillInLabel;

  String get hfTokenFillInHint;

  String get hfTokenSuccessMessage;

  String get hfCreateTokenHelp;

  String get hfVerifyTokenPerms;

  String get modelDelete;

  String get modelDownload;

  String get modelDownloadFailure;

  String modelDownloadProgress(double progress);

  String get modelLicense;

  String get useThisModel;

  String get genericConfirm;

  String get genericDeny;

  /// No description provided for @imageSupportInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Model supports images'**
  String get imageSupportInfoTitle;

  /// No description provided for @imageSupportInfoBody.
  ///
  /// In en, this message translates to:
  /// **'Use the 📷 button to send images'**
  String get imageSupportInfoBody;

  /// No description provided for @errorBannerMessage.
  ///
  /// In en, this message translates to:
  /// **'{errorMessage}'**
  String errorBannerMessage(Object errorMessage);

  /// Text for the button that alternates home layout
  ///
  /// In en, this message translates to:
  /// **'Toggle view'**
  String get buttonToggleView;

  /// Main welcome title on HomeScreen
  ///
  /// In en, this message translates to:
  /// **'Welcome to Waters of Borborema'**
  String get homeWelcomeTitle;

  /// Subtitle under welcome title on HomeScreen
  ///
  /// In en, this message translates to:
  /// **'Explore our solution for natural disaster assistance'**
  String get homeWelcomeSubtitle;

  /// Subtitle for Chat card
  ///
  /// In en, this message translates to:
  /// **'Browse a range of models running locally on your device!'**
  String get homeChatSubtitle;

  /// Subtitle for Map card
  ///
  /// In en, this message translates to:
  /// **'See new forecast updates on the map!'**
  String get homeMapSubtitle;

  /// Subtitle for Forecasts card
  ///
  /// In en, this message translates to:
  /// **'Check out the latest forecasts!'**
  String get homeForecastSubtitle;

  /// Subtitle for Contacts card
  ///
  /// In en, this message translates to:
  /// **'Access your contacts list.'**
  String get homeContactsSubtitle;

  /// Subtitle for Settings card
  ///
  /// In en, this message translates to:
  /// **'Go to model, home & contacts settings.'**
  String get homeSettingsSubtitle;

  /// Title of the saved contacts screen
  ///
  /// In en, this message translates to:
  /// **'Saved Contacts'**
  String get contactsTitle;

  /// Message shown when there are no contacts
  ///
  /// In en, this message translates to:
  /// **'Add a new contact.'**
  String get contactsEmptyMessage;

  /// Option to edit contact
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get contactsEdit;

  /// Option to delete contact
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get contactsDelete;

  /// Confirmation message to delete contact
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this contact?'**
  String get deleteContactConfirmation;

  /// Cancel button text in dialogs
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get buttonCancel;

  /// Save button text in dialogs
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get buttonSave;

  /// Label for name field in update contact dialog
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get updateContactLabelName;

  /// Label for address field in update contact dialog
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get updateContactLabelAddress;

  /// Label for name field in add contact dialog
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get addContactLabelName;

  /// Hint text for location field in add contact dialog
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get addContactHintLocation;

  /// Message shown above the map indicating points that suffered flooding
  ///
  /// In en, this message translates to:
  /// **'Highlighted points suffered flooding!'**
  String get highlightedFloodPoints;

  /// Message shown when user tries to select image on the web version
  ///
  /// In en, this message translates to:
  /// **'Image selection is not yet supported on the web'**
  String get imageSelectionNotSupportedWeb;

  /// Error message shown when there's a problem selecting an image
  ///
  /// In en, this message translates to:
  /// **'Error selecting image: {error}'**
  String errorSelectingImage(Object error);

  /// Tooltip for the add image button in the chat
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get addImageTooltip;

  /// Placeholder text for the input field when an image is selected
  ///
  /// In en, this message translates to:
  /// **'Add description to the image...'**
  String get addDescriptionToImage;

  /// Placeholder text for the input field when no image is selected
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get sendMessage;

  /// Default name for images in the image preview
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get imageLabel;

  /// Tooltip for the button that removes the selected image
  ///
  /// In en, this message translates to:
  /// **'Remove image'**
  String get removeImageTooltip;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
