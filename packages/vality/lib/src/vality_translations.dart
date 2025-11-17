import 'package:meta/meta.dart';
import 'package:vality/src/vality_issue.dart';
import 'package:vality/src/base_validator/vality_rule_base.dart';
import 'package:vality/src/vality_params.dart';

/// Abstract base class for translating ValityIssue to user-friendly messages
///
/// Extend this class to provide custom translations for validation errors.
/// The library provides [DefaultValityTranslations] with English defaults.
///
/// **Example - Custom translations:**
/// ```dart
/// class MyTranslations extends ValityTranslations {
///   @override
///   String notNull() => 'Field ini wajib diisi';
///
///   @override
///   String minLength(int min) => 'Minimal $min karakter';
///
///   // ... implement all methods
/// }
/// ```
///
/// **Example - Extend defaults:**
/// ```dart
/// class MyTranslations extends DefaultValityTranslations {
///   @override
///   String notNull() => 'Custom message'; // Override only what needed
///   // Other methods inherit from DefaultValityTranslations
/// }
/// ```
abstract class ValityTranslations {
  // Common errors
  String notNull();
  String notEmpty();

  // Length errors
  String minLength(int min);
  String maxLength(int max);

  // Email errors
  String email();

  // URL errors
  String url();

  // String content errors
  String contains(String substring);
  String containsNofString(int minCount, String substring);
  String containsNofRegex(int minCount);
  String startsWith();
  String endsWith();
  String matches();

  // Alphanumeric errors
  String alphanumeric();
  String numeric();

  // Password character requirements
  String containsUpperCase(int minCount);
  String containsLowerCase(int minCount);
  String containsNumbers(int minCount);
  String containsSpecialChar(int minCount);

  // Number errors
  String minValue(num min);
  String maxValue(num max);
  String range(num min, num max);
  String positive();
  String negative();
  String integer();
  String doubleValue();

  // List errors
  String containsItem();
  String uniqueItems();

  // Map errors
  String containsKey();
  String containsValue();

  // Custom error codes
  /// Translate a custom error code that's not part of the standard validation rules
  ///
  /// Override this method to provide translations for your custom error codes.
  /// Return `null` to fall back to [validationError()].
  ///
  /// **Example:**
  /// ```dart
  /// class MyTranslations extends DefaultValityTranslations {
  ///   @override
  ///   String? translateCustom(String code, Map<String, dynamic>? params) {
  ///     switch (code) {
  ///       case 'passwordMismatch':
  ///         return 'Passwords do not match';
  ///       case 'customError':
  ///         return 'Custom error message';
  ///       default:
  ///         return null; // Fall back to validationError()
  ///     }
  ///   }
  /// }
  /// ```
  String? translateCustom(ValityIssue issue);

  // Default error message for unknown/custom error codes
  String validationError();
}

/// Default English translations for validation errors
///
/// This provides English error messages out of the box.
/// Users can extend this class to override specific messages.
///
/// **Example:**
/// ```dart
/// class IndonesianTranslations extends DefaultValityTranslations {
///   @override
///   String notNull() => 'Field ini wajib diisi';
/// }
/// ```
class DefaultValityTranslations extends ValityTranslations {
  @override
  String notNull() => 'This field is required';

  @override
  String notEmpty() => 'This field cannot be empty';

  @override
  String minLength(int min) => 'Must be at least $min characters';

  @override
  String maxLength(int max) => 'Must be at most $max characters';

  @override
  String email() => 'Please enter a valid email address';

  @override
  String url() => 'Please enter a valid URL';

  @override
  String contains(String substring) => 'Must contain "$substring"';

  @override
  String containsNofString(int minCount, String substring) =>
      'Must contain at least $minCount occurrence(s) of "$substring"';

  @override
  String containsNofRegex(int minCount) =>
      'Must contain at least $minCount match(es)';

  @override
  String startsWith() => 'Must start with the specified prefix';

  @override
  String endsWith() => 'Must end with the specified suffix';

  @override
  String matches() => 'Must match the specified pattern';

  @override
  String alphanumeric() => 'Only letters and numbers are allowed';

  @override
  String numeric() => 'Only numbers are allowed';

  @override
  String containsUpperCase(int minCount) =>
      'Must contain at least $minCount uppercase letter(s)';

  @override
  String containsLowerCase(int minCount) =>
      'Must contain at least $minCount lowercase letter(s)';

  @override
  String containsNumbers(int minCount) =>
      'Must contain at least $minCount number(s)';

  @override
  String containsSpecialChar(int minCount) =>
      'Must contain at least $minCount special character(s)';

  @override
  String minValue(num min) => 'Must be at least $min';

  @override
  String maxValue(num max) => 'Must be at most $max';

  @override
  String range(num min, num max) => 'Must be between $min and $max';

  @override
  String positive() => 'Must be a positive number';

  @override
  String negative() => 'Must be a negative number';

  @override
  String integer() => 'Must be an integer';

  @override
  String doubleValue() => 'Must be a decimal number';

  @override
  String containsItem() => 'Must contain the specified item';

  @override
  String uniqueItems() => 'All items must be unique';

  @override
  String containsKey() => 'Must contain the specified key';

  @override
  String containsValue() => 'Must contain the specified value';

  @override
  String? translateCustom(ValityIssue issue) => null;

  @override
  String validationError() => 'Validation error';
}

/// Helper class for translating ValityIssue using ValityTranslations
///
/// **Usage with custom translations:**
/// ```dart
/// final translations = MyCustomTranslations();
/// final error = ValityTranslationsHelper.translate(issue, translations);
/// ```
///
/// **Usage with default translations:**
/// ```dart
/// final error = ValityTranslationsHelper.translateDefault(issue);
/// ```
class ValityTranslationsHelper {
  /// Registry map for standard error codes
  ///
  /// Maps each [ValityRuleBase] constant to a function that extracts
  /// the appropriate translation from a [ValityTranslations] instance.
  ///
  /// **Maintenance Note:**
  /// When adding a new error code to [ValityRuleBase], you must:
  /// 1. Add the constant to [ValityRuleBase]
  /// 2. Add the method to [ValityTranslations] abstract class
  /// 3. Implement it in [DefaultValityTranslations]
  /// 4. Add an entry to this registry map
  /// 5. Run tests to verify completeness
  ///
  /// **Example entry:**
  /// ```dart
  /// ValityRuleBase.notNull: (t, issue) => t.notNull(),
  /// ```
  @visibleForTesting
  static final Map<String, String Function(ValityTranslations, ValityIssue)>
      errorCodeRegistry = {
    // Common errors
    ValityRuleBase.notNull: (t, issue) => t.notNull(),
    ValityRuleBase.notEmpty: (t, issue) => t.notEmpty(),

    // Length errors
    ValityRuleBase.minLength: (t, issue) {
      final min = issue.params?[ValityParams.min] as int?;
      return t.minLength(min ?? 0);
    },
    ValityRuleBase.maxLength: (t, issue) {
      final max = issue.params?[ValityParams.max] as int?;
      return t.maxLength(max ?? 0);
    },

    // Email errors
    ValityRuleBase.email: (t, issue) => t.email(),

    // URL errors
    ValityRuleBase.url: (t, issue) => t.url(),

    // String content errors
    ValityRuleBase.contains: (t, issue) {
      final substring = issue.params?[ValityParams.substring] as String?;
      return t.contains(substring ?? '');
    },
    ValityRuleBase.containsNofString: (t, issue) {
      final substring = issue.params?[ValityParams.substring] as String?;
      final minCount = issue.params?[ValityParams.minCount] as int?;
      return t.containsNofString(minCount ?? 0, substring ?? '');
    },
    ValityRuleBase.containsNofRegex: (t, issue) {
      final minCount = issue.params?[ValityParams.minCount] as int?;
      return t.containsNofRegex(minCount ?? 0);
    },
    ValityRuleBase.startsWith: (t, issue) => t.startsWith(),
    ValityRuleBase.endsWith: (t, issue) => t.endsWith(),
    ValityRuleBase.matches: (t, issue) => t.matches(),

    // Alphanumeric errors
    ValityRuleBase.alphanumeric: (t, issue) => t.alphanumeric(),
    ValityRuleBase.numeric: (t, issue) => t.numeric(),

    // Password character requirements
    ValityRuleBase.containsUpperCase: (t, issue) {
      final minCount = issue.params?[ValityParams.minCount] as int?;
      return t.containsUpperCase(minCount ?? 1);
    },
    ValityRuleBase.containsLowerCase: (t, issue) {
      final minCount = issue.params?[ValityParams.minCount] as int?;
      return t.containsLowerCase(minCount ?? 1);
    },
    ValityRuleBase.containsNumbers: (t, issue) {
      final minCount = issue.params?[ValityParams.minCount] as int?;
      return t.containsNumbers(minCount ?? 1);
    },
    ValityRuleBase.containsSpecialChar: (t, issue) {
      final minCount = issue.params?[ValityParams.minCount] as int?;
      return t.containsSpecialChar(minCount ?? 1);
    },

    // Number errors
    ValityRuleBase.minValue: (t, issue) {
      final min = issue.params?[ValityParams.min] as num?;
      return t.minValue(min ?? 0);
    },
    ValityRuleBase.maxValue: (t, issue) {
      final max = issue.params?[ValityParams.max] as num?;
      return t.maxValue(max ?? 0);
    },
    ValityRuleBase.range: (t, issue) {
      final min = issue.params?[ValityParams.min] as num?;
      final max = issue.params?[ValityParams.max] as num?;
      return t.range(min ?? 0, max ?? 0);
    },
    ValityRuleBase.positive: (t, issue) => t.positive(),
    ValityRuleBase.negative: (t, issue) => t.negative(),
    ValityRuleBase.integer: (t, issue) => t.integer(),
    ValityRuleBase.double: (t, issue) => t.doubleValue(),

    // List errors
    ValityRuleBase.containsItem: (t, issue) => t.containsItem(),
    ValityRuleBase.uniqueItems: (t, issue) => t.uniqueItems(),

    // Map errors
    ValityRuleBase.containsKey: (t, issue) => t.containsKey(),
    ValityRuleBase.containsValue: (t, issue) => t.containsValue(),
  };

  /// Get all standard error codes from [ValityRuleBase]
  ///
  /// This is used for testing to ensure all error codes have registry entries.
  static List<String> getAllStandardErrorCodes() {
    return [
      ValityRuleBase.notNull,
      ValityRuleBase.notEmpty,
      ValityRuleBase.minLength,
      ValityRuleBase.maxLength,
      ValityRuleBase.email,
      ValityRuleBase.url,
      ValityRuleBase.contains,
      ValityRuleBase.containsNofString,
      ValityRuleBase.containsNofRegex,
      ValityRuleBase.containsUpperCase,
      ValityRuleBase.containsLowerCase,
      ValityRuleBase.containsNumbers,
      ValityRuleBase.containsSpecialChar,
      ValityRuleBase.startsWith,
      ValityRuleBase.endsWith,
      ValityRuleBase.matches,
      ValityRuleBase.alphanumeric,
      ValityRuleBase.numeric,
      ValityRuleBase.minValue,
      ValityRuleBase.maxValue,
      ValityRuleBase.range,
      ValityRuleBase.positive,
      ValityRuleBase.negative,
      ValityRuleBase.integer,
      ValityRuleBase.double,
      ValityRuleBase.containsItem,
      ValityRuleBase.uniqueItems,
      ValityRuleBase.containsKey,
      ValityRuleBase.containsValue,
    ];
  }

  /// Translate a ValityIssue using the provided ValityTranslations instance
  ///
  /// **Parameters:**
  /// - `issue`: The validation issue to translate
  /// - `translations`: The translations instance to use
  ///
  /// **Returns:** A user-friendly error message string
  ///
  /// **How it works:**
  /// 1. Checks the registry map for standard error codes
  /// 2. If not found, calls `translateCustom()` for custom error codes
  /// 3. Falls back to `validationError()` if no translation is found
  static String translate(
    ValityIssue issue,
    ValityTranslations translations,
  ) {
    // Check registry for standard error codes
    final translator = errorCodeRegistry[issue.code];
    if (translator != null) {
      return translator(translations, issue);
    }

    // Check for custom error codes
    final customTranslation = translations.translateCustom(issue);
    if (customTranslation != null) {
      return customTranslation;
    }

    // Fall back to generic error message
    return translations.validationError();
  }

  /// Translate a ValityIssue using default English translations
  ///
  /// This is a convenience method that uses [DefaultValityTranslations].
  /// Useful when you don't need custom translations.
  ///
  /// **Usage:**
  /// ```dart
  /// final error = ValityTranslationsHelper.translateDefault(issue);
  /// ```
  static String translateDefault(ValityIssue issue) {
    return translate(issue, DefaultValityTranslations());
  }
}
