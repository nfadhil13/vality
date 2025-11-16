import 'package:example_bloc/l10n/app_localizations.dart';
import 'package:vality/vality.dart';

/// Adapter that bridges AppLocalizations (Flutter) with ValityTranslations (vality library)
///
/// This allows you to use Flutter's AppLocalizations with the vality library's
/// translation system.
///
/// **Usage:**
/// ```dart
/// final appLocalizations = AppLocalizations.of(context)!;
/// final adapter = AppLocalizationsValityAdapter(appLocalizations);
/// final error = ValityTranslationsHelper.translate(issue, adapter);
/// ```
///
/// **Or use the extension:**
/// ```dart
/// final appLocalizations = AppLocalizations.of(context)!;
/// final error = ValityTranslationsHelper.translate(
///   issue,
///   appLocalizations.toValityTranslations(),
/// );
/// ```
///
/// **Maintenance Pattern:**
/// This adapter implements all methods from [ValityTranslations] by delegating
/// to the corresponding getters/methods in [AppLocalizations].
///
/// When the vality library adds a new standard error code:
/// 1. The library maintainer adds it to [ValityRuleBase]
/// 2. The library maintainer adds it to [ValityTranslations] and registry
/// 3. **You must add the corresponding getter/method to your AppLocalizations**
///    (via `.arb` files and `flutter gen-l10n`)
/// 4. **You must add the corresponding method here** to delegate to AppLocalizations
///
/// **Example:**
/// If a new error code `newError` is added:
/// ```dart
/// @override
/// String newError() => _localizations.newError;
/// ```
///
/// **Testing:**
/// The vality library includes tests to ensure all standard error codes have
/// registry entries. Your adapter should implement all methods from ValityTranslations.
class AppLocalizationsValityAdapter extends ValityTranslations {
  final AppLocalizations _localizations;

  AppLocalizationsValityAdapter(this._localizations);

  @override
  String notNull() => _localizations.notNull;

  @override
  String notEmpty() => _localizations.notEmpty;

  @override
  String minLength(int min) => _localizations.minLength(min);

  @override
  String maxLength(int max) => _localizations.maxLength(max);

  @override
  String email() => _localizations.email;

  @override
  String url() => _localizations.url;

  @override
  String contains(String substring) => _localizations.contains(substring);

  @override
  String containsNofString(int minCount, String substring) =>
      _localizations.containsNofString(minCount, substring);

  @override
  String containsNofRegex(int minCount) =>
      _localizations.containsNofRegex(minCount);

  @override
  String startsWith() => _localizations.startsWith;

  @override
  String endsWith() => _localizations.endsWith;

  @override
  String matches() => _localizations.matches;

  @override
  String alphanumeric() => _localizations.alphanumeric;

  @override
  String numeric() => _localizations.numeric;

  @override
  String containsUpperCase(int minCount) =>
      _localizations.containsUpperCase(minCount);

  @override
  String containsLowerCase(int minCount) =>
      _localizations.containsLowerCase(minCount);

  @override
  String containsNumbers(int minCount) =>
      _localizations.containsNumbers(minCount);

  @override
  String containsSpecialChar(int minCount) =>
      _localizations.containsSpecialChar(minCount);

  @override
  String minValue(num min) => _localizations.minValue(min);

  @override
  String maxValue(num max) => _localizations.maxValue(max);

  @override
  String range(num min, num max) => _localizations.range(min, max);

  @override
  String positive() => _localizations.positive;

  @override
  String negative() => _localizations.negative;

  @override
  String integer() => _localizations.integer;

  @override
  String doubleValue() => _localizations.double;

  @override
  String containsItem() => _localizations.containsItem;

  @override
  String uniqueItems() => _localizations.uniqueItems;

  @override
  String containsKey() => _localizations.containsKey;

  @override
  String containsValue() => _localizations.containsValue;

  @override
  String? translateCustom(ValityIssue issue) {
    switch (issue.code) {
      case 'passwordMismatch':
        return _localizations.passwordMismatch;
      default:
        return null; // Fall back to validationError()
    }
  }

  @override
  String validationError() => _localizations.validationError;
}

/// Extension to convert AppLocalizations to ValityTranslations
extension AppLocalizationsValityExtension on AppLocalizations {
  /// Convert AppLocalizations to ValityTranslations adapter
  ///
  /// **Usage:**
  /// ```dart
  /// final localizations = AppLocalizations.of(context)!;
  /// final error = ValityTranslationsHelper.translate(
  ///   issue,
  ///   localizations.toValityTranslations(),
  /// );
  /// ```
  ValityTranslations toValityTranslations() {
    return AppLocalizationsValityAdapter(this);
  }
}
