/// Constants for parameter keys used in [ValityIssue.params]
///
/// Provides type-safe access to parameter keys, preventing typos
/// and enabling IDE autocomplete when accessing validation issue parameters.
///
/// **Example:**
/// ```dart
/// final issue = validator(value);
/// if (issue?.code == ValityRuleBase.minLength) {
///   final min = issue?.params?[ValityParams.min] as int?;
///   final length = issue?.params?[ValityParams.length] as int?;
///   print('Required: $min, Actual: $length');
/// }
/// ```
class ValityParams {
  ValityParams._(); // coverage:ignore-line

  // ============================================================================
  // Length Parameters
  // ============================================================================

  /// Minimum value/length required
  static const String min = 'min';

  /// Maximum value/length allowed
  static const String max = 'max';

  /// Actual length of the value
  static const String length = 'length';

  // ============================================================================
  // Count Parameters
  // ============================================================================

  /// Minimum count required (e.g., minimum number of uppercase letters)
  static const String minCount = 'minCount';

  // ============================================================================
  // Value Parameters
  // ============================================================================

  /// Actual value being validated
  static const String value = 'value';

  // ============================================================================
  // String Parameters
  // ============================================================================

  /// Substring being searched for
  static const String substring = 'substring';

  // ============================================================================
  // Collection Parameters
  // ============================================================================

  /// Item being searched for in a collection
  static const String item = 'item';
}
