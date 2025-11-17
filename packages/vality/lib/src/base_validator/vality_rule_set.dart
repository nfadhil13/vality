part of 'vality_rule_base.dart';

// ============================================================================
// Set Length Validators
// ============================================================================

/// Validates that a Set has minimum length
///
/// **Error Code:** `ValityRuleBase.minLength`
///
/// **Parameters:**
/// - `min` (int): The minimum required length
/// - `length` (int): The actual length of the set
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.minLength) {
///   final min = issue?.params?[ValityParams.min] as int?;
///   print('Minimum set length required: $min');
/// }
/// ```
ValityRule<Set<T>?> minLengthSet<T>(int min) =>
    minLength<Set<T>?>(min, (value) => value?.length ?? 0);

/// Validates that a Set has maximum length
///
/// **Error Code:** `ValityRuleBase.maxLength`
///
/// **Parameters:**
/// - `max` (int): The maximum allowed length
/// - `length` (int): The actual length of the set
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.maxLength) {
///   final max = issue?.params?[ValityParams.max] as int?;
///   print('Maximum set length allowed: $max');
/// }
/// ```
ValityRule<Set<T>?> maxLengthSet<T>(int max) =>
    maxLength<Set<T>?>(max, (value) => value?.length ?? 0);

// ============================================================================
// Set Content Validators
// ============================================================================

/// Validates that a Set contains a specific item
///
/// **Error Code:** `ValityRuleBase.containsItem`
///
/// **Parameters:**
/// - `item` (T): The item that must be contained in the set
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.containsItem) {
///   final item = issue?.params?[ValityParams.item];
///   print('Set must contain: $item');
/// }
/// ```
ValityRule<Set<T>?> containsItemSet<T>(T item) =>
    (value) => value == null || !value.contains(item)
    ? ValityIssue(
        code: ValityRuleBase.containsItem,
        params: {ValityParams.item: item},
      )
    : null;
