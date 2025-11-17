part of 'vality_rule_base.dart';

// ============================================================================
// List Length Validators
// ============================================================================

/// Validates that a List has minimum length
///
/// **Error Code:** `ValityRuleBase.minLength`
///
/// **Parameters:**
/// - `min` (int): The minimum required length
/// - `length` (int): The actual length of the list
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.minLength) {
///   final min = issue?.params?[ValityParams.min] as int?;
///   print('Minimum list length required: $min');
/// }
/// ```
ValityRule<List<T>?> minLengthList<T>(int min) =>
    minLength<List<T>?>(min, (value) => value?.length ?? 0);

/// Validates that a List has maximum length
///
/// **Error Code:** `ValityRuleBase.maxLength`
///
/// **Parameters:**
/// - `max` (int): The maximum allowed length
/// - `length` (int): The actual length of the list
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.maxLength) {
///   final max = issue?.params?[ValityParams.max] as int?;
///   print('Maximum list length allowed: $max');
/// }
/// ```
ValityRule<List<T>?> maxLengthList<T>(int max) =>
    maxLength<List<T>?>(max, (value) => value?.length ?? 0);

// ============================================================================
// List Content Validators
// ============================================================================

/// Validates that a List contains a specific item
///
/// **Error Code:** `ValityRuleBase.containsItem`
///
/// **Parameters:**
/// - `item` (T): The item that must be contained in the list
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.containsItem) {
///   final item = issue?.params?[ValityParams.item];
///   print('List must contain: $item');
/// }
/// ```
ValityRule<List<T>?> containsItem<T>(T item) =>
    (value) => value == null || !value.contains(item)
    ? ValityIssue(
        code: ValityRuleBase.containsItem,
        params: {ValityParams.item: item},
      )
    : null;

/// Validates that all items in a List are unique
///
/// **Error Code:** `ValityRuleBase.uniqueItems`
///
/// **Parameters:**
/// - `length` (int): The length of the list (when duplicates are found)
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.uniqueItems) {
///   final length = issue?.params?[ValityParams.length] as int?;
///   print('List has $length items but contains duplicates');
/// }
/// ```
ValityRule<List<T>?> uniqueItems<T>() => (value) {
  if (value == null) return ValityIssue(code: ValityRuleBase.uniqueItems);
  final uniqueSet = value.toSet();
  return uniqueSet.length != value.length
      ? ValityIssue(
          code: ValityRuleBase.uniqueItems,
          params: {ValityParams.length: value.length},
        )
      : null;
};
