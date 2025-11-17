import 'package:vality/src/vality_issue.dart';

/// A function type that validates a value and returns a validation issue
///
/// Returns `ValityIssue?` - `null` if validation passes, or a `ValityIssue`
/// if validation fails.
///
/// **Example:**
/// ```dart
/// // Create a custom rule
/// ValityRule<String?> customRule = (value) {
///   if (value == null || value.isEmpty) {
///     return ValityIssue(code: 'customError');
///   }
///   return null; // Valid
/// };
///
/// // Use in schema
/// final schema = ValitySchema<String?>([customRule]);
/// ```
typedef ValityRule<T> = ValityIssue? Function(T value);

/// Builder class for validating values against multiple rules
///
/// Rules are validated in order, and validation stops at the first rule that fails.
class ValityRuleBuilder {
  /// Validates a value against a list of rules
  ///
  /// **Parameters:**
  /// - `rules` (List\<ValityRule\<T>>): The list of validation rules to apply
  /// - `value` (`T`): The value to validate
  ///
  /// **Returns:** `ValityIssue?` - The first validation issue found, or `null` if all rules pass.
  ///
  /// **Example:**
  /// ```dart
  /// final rules = [
  ///   notNull(),
  ///   notEmpty(),
  ///   minLengthString(5),
  /// ];
  ///
  /// final issue = ValityRuleBuilder.validate<String?>(rules, 'abc');
  /// if (issue != null) {
  ///   print('Validation failed: ${issue.code}');
  /// }
  /// ```
  static ValityIssue? validate<T>(List<ValityRule<T>> rules, T value) {
    for (final rule in rules) {
      final issue = rule(value);
      if (issue != null) return issue;
    }
    return null;
  }
}
