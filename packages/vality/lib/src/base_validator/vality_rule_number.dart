part of 'vality_rule_base.dart';

// ============================================================================
// Number Validators
// ============================================================================

/// Validates that a number is greater than or equal to minimum value
///
/// **Error Code:** `ValityRuleBase.minValue`
///
/// **Parameters:**
/// - `min` (num): The minimum allowed value
/// - `value` (num?): The actual value being validated
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.minValue) {
///   final min = issue?.params?[ValityParams.min] as num?;
///   final value = issue?.params?[ValityParams.value] as num?;
///   print('Minimum: $min, Actual: $value');
/// }
/// ```
ValityRule<num?> minValue(num min) =>
    (value) => value == null || value < min
    ? ValityIssue(
        code: ValityRuleBase.minValue,
        params: {ValityParams.min: min, ValityParams.value: value},
      )
    : null;

/// Validates that a number is less than or equal to maximum value
///
/// **Error Code:** `ValityRuleBase.maxValue`
///
/// **Parameters:**
/// - `max` (num): The maximum allowed value
/// - `value` (num?): The actual value being validated
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.maxValue) {
///   final max = issue?.params?[ValityParams.max] as num?;
///   final value = issue?.params?[ValityParams.value] as num?;
///   print('Maximum: $max, Actual: $value');
/// }
/// ```
ValityRule<num?> maxValue(num max) =>
    (value) => value == null || value > max
    ? ValityIssue(
        code: ValityRuleBase.maxValue,
        params: {ValityParams.max: max, ValityParams.value: value},
      )
    : null;

/// Validates that a number is within a range (inclusive)
///
/// **Error Code:** `ValityRuleBase.range`
///
/// **Parameters:**
/// - `min` (num): The minimum allowed value
/// - `max` (num): The maximum allowed value
/// - `value` (num?): The actual value being validated
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.range) {
///   final min = issue?.params?[ValityParams.min] as num?;
///   final max = issue?.params?[ValityParams.max] as num?;
///   final value = issue?.params?[ValityParams.value] as num?;
///   print('Range: $min - $max, Actual: $value');
/// }
/// ```
ValityRule<num?> range(num min, num max) => (value) {
  if (value == null) {
    return ValityIssue(
      code: ValityRuleBase.range,
      params: {
        ValityParams.min: min,
        ValityParams.max: max,
        ValityParams.value: 0,
      },
    );
  }
  return value < min || value > max
      ? ValityIssue(
          code: ValityRuleBase.range,
          params: {
            ValityParams.min: min,
            ValityParams.max: max,
            ValityParams.value: value,
          },
        )
      : null;
};

/// Validates that a number is positive (greater than 0)
ValityRule<num?> positive() =>
    (value) => value == null || value <= 0
    ? ValityIssue(code: ValityRuleBase.positive)
    : null;

/// Validates that a number is negative (less than 0)
ValityRule<num?> negative() =>
    (value) => value == null || value >= 0
    ? ValityIssue(code: ValityRuleBase.negative)
    : null;

/// Validates that a number is an integer
ValityRule<num?> integer() =>
    (value) => value == null || value % 1 != 0
    ? ValityIssue(code: ValityRuleBase.integer)
    : null;
