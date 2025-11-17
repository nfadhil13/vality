import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @notNull.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get notNull;

  /// No description provided for @notEmpty.
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get notEmpty;

  /// No description provided for @minLength.
  ///
  /// In en, this message translates to:
  /// **'Must be at least {min} characters'**
  String minLength(int min);

  /// No description provided for @maxLength.
  ///
  /// In en, this message translates to:
  /// **'Must be at most {max} characters'**
  String maxLength(int max);

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get email;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get url;

  /// No description provided for @contains.
  ///
  /// In en, this message translates to:
  /// **'Must contain \"{substring}\"'**
  String contains(String substring);

  /// No description provided for @containsNofString.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least {minCount} occurrence(s) of \"{substring}\"'**
  String containsNofString(int minCount, String substring);

  /// No description provided for @containsNofRegex.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least {minCount} match(es)'**
  String containsNofRegex(int minCount);

  /// No description provided for @startsWith.
  ///
  /// In en, this message translates to:
  /// **'Must start with the specified prefix'**
  String get startsWith;

  /// No description provided for @endsWith.
  ///
  /// In en, this message translates to:
  /// **'Must end with the specified suffix'**
  String get endsWith;

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Must match the specified pattern'**
  String get matches;

  /// No description provided for @alphanumeric.
  ///
  /// In en, this message translates to:
  /// **'Only letters and numbers are allowed'**
  String get alphanumeric;

  /// No description provided for @numeric.
  ///
  /// In en, this message translates to:
  /// **'Only numbers are allowed'**
  String get numeric;

  /// No description provided for @containsUpperCase.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least {minCount} uppercase letter(s)'**
  String containsUpperCase(int minCount);

  /// No description provided for @containsLowerCase.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least {minCount} lowercase letter(s)'**
  String containsLowerCase(int minCount);

  /// No description provided for @containsNumbers.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least {minCount} number(s)'**
  String containsNumbers(int minCount);

  /// No description provided for @containsSpecialChar.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least {minCount} special character(s)'**
  String containsSpecialChar(int minCount);

  /// No description provided for @minValue.
  ///
  /// In en, this message translates to:
  /// **'Must be at least {min}'**
  String minValue(num min);

  /// No description provided for @maxValue.
  ///
  /// In en, this message translates to:
  /// **'Must be at most {max}'**
  String maxValue(num max);

  /// No description provided for @range.
  ///
  /// In en, this message translates to:
  /// **'Must be between {min} and {max}'**
  String range(num min, num max);

  /// No description provided for @positive.
  ///
  /// In en, this message translates to:
  /// **'Must be a positive number'**
  String get positive;

  /// No description provided for @negative.
  ///
  /// In en, this message translates to:
  /// **'Must be a negative number'**
  String get negative;

  /// No description provided for @integer.
  ///
  /// In en, this message translates to:
  /// **'Must be an integer'**
  String get integer;

  /// No description provided for @double.
  ///
  /// In en, this message translates to:
  /// **'Must be a decimal number'**
  String get double;

  /// No description provided for @containsItem.
  ///
  /// In en, this message translates to:
  /// **'Must contain the specified item'**
  String get containsItem;

  /// No description provided for @uniqueItems.
  ///
  /// In en, this message translates to:
  /// **'All items must be unique'**
  String get uniqueItems;

  /// No description provided for @containsKey.
  ///
  /// In en, this message translates to:
  /// **'Must contain the specified key'**
  String get containsKey;

  /// No description provided for @containsValue.
  ///
  /// In en, this message translates to:
  /// **'Must contain the specified value'**
  String get containsValue;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Validation error'**
  String get validationError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
