part of 'vality_rule_base.dart';

// ============================================================================
// Common Validators
// ============================================================================

/// Validates that a value is not null
ValityRule<T> notNull<T>() =>
    (value) => value == null ? ValityIssue(code: ValityRuleBase.notNull) : null;

// ============================================================================
// Length Validators - Base Generic Functions
// ============================================================================

/// Base generic length validator
/// Use this for custom types that need length validation
///
/// **Error Code:** `ValityRuleBase.minLength`
///
/// **Parameters:**
/// - `min` (int): The minimum required length
/// - `length` (int): The actual length of the value
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.minLength) {
///   final min = issue?.params?[ValityParams.min] as int?;
///   final length = issue?.params?[ValityParams.length] as int?;
///   print('Required: $min, Actual: $length');
/// }
/// ```
ValityRule<T> minLength<T>(int min, int Function(T value) getLength) {
  return (value) {
    if (value == null) {
      return ValityIssue(
        code: ValityRuleBase.minLength,
        params: {ValityParams.min: min, ValityParams.length: 0},
      );
    }
    final length = getLength(value);
    return length < min
        ? ValityIssue(
            code: ValityRuleBase.minLength,
            params: {ValityParams.min: min, ValityParams.length: length},
          )
        : null;
  };
}

/// Base generic length validator
///
/// **Error Code:** `ValityRuleBase.maxLength`
///
/// **Parameters:**
/// - `max` (int): The maximum allowed length
/// - `length` (int): The actual length of the value
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.maxLength) {
///   final max = issue?.params?[ValityParams.max] as int?;
///   final length = issue?.params?[ValityParams.length] as int?;
///   print('Maximum: $max, Actual: $length');
/// }
/// ```
ValityRule<T> maxLength<T>(int max, int Function(T value) getLength) {
  return (value) {
    if (value == null) {
      return ValityIssue(
        code: ValityRuleBase.maxLength,
        params: {ValityParams.max: max, ValityParams.length: 0},
      );
    }
    final length = getLength(value);
    return length > max
        ? ValityIssue(
            code: ValityRuleBase.maxLength,
            params: {ValityParams.max: max, ValityParams.length: length},
          )
        : null;
  };
}
