import 'package:equatable/equatable.dart';

/// Represents a validation error/issue returned by a validation rule
///
/// Contains an error code and optional parameters that can be used
/// for i18n translations or custom error handling.
///
/// **Example:**
/// ```dart
/// // Simple issue without parameters
/// final issue = ValityIssue(code: ValityRuleBase.notNull);
///
/// // Issue with parameters
/// final issue = ValityIssue(
///   code: ValityRuleBase.minLength,
///   params: {ValityParams.min: 8, ValityParams.length: 5},
/// );
///
/// // Access error code
/// print('Error code: ${issue.code}');
///
/// // Access parameters using type-safe constants
/// if (issue.params != null) {
///   final min = issue.params?[ValityParams.min] as int?;
///   print('Minimum required: $min');
/// }
/// ```
class ValityIssue extends Equatable {
  /// The error code representing the validation issue
  ///
  /// This is typically a constant from `ValityRuleBase` (e.g., `ValityRuleBase.notNull`),
  /// but can also be a custom string key for translation files.
  final String code;

  /// Optional parameters for the validation issue
  ///
  /// Useful for i18n translations that require dynamic values.
  /// Use [ValityParams] constants for type-safe parameter keys.
  ///
  /// Common parameter keys (use [ValityParams] constants):
  /// - `ValityParams.min` (int): Minimum value/length required
  /// - `ValityParams.max` (int): Maximum value/length allowed
  /// - `ValityParams.minCount` (int): Minimum count required
  /// - `ValityParams.length` (int): Actual length/value
  /// - `ValityParams.value` (num?): Actual value being validated
  /// - `ValityParams.substring` (String): Substring being searched for
  /// - `ValityParams.item` (dynamic): Item being searched for in collections
  ///
  /// **Example:**
  /// ```dart
  /// // Length validation params
  /// {ValityParams.min: 8, ValityParams.length: 5}
  ///
  /// // Range validation params
  /// {ValityParams.min: 5, ValityParams.max: 10, ValityParams.value: 12}
  ///
  /// // Count validation params
  /// {ValityParams.minCount: 2}
  /// ```
  final Map<String, dynamic>? params;

  /// Creates a ValityIssue with the given code and optional parameters
  ///
  /// **Parameters:**
  /// - `code` (String): The error code (required)
  /// - `params` (Map<String, dynamic>?): Optional parameters for the issue
  ///
  /// **Example:**
  /// ```dart
  /// const issue = ValityIssue(
  ///   code: ValityRuleBase.minLength,
  ///   params: {ValityParams.min: 8},
  /// );
  /// ```
  const ValityIssue({
    required this.code,
    this.params,
  });

  @override
  List<Object?> get props => [code, params];
}
