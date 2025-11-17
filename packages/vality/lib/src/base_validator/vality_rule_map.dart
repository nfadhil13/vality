part of vality_rule_base;

// ============================================================================
// Map Length Validators
// ============================================================================

/// Validates that a Map has minimum length
///
/// **Error Code:** `ValityRuleBase.minLength`
///
/// **Parameters:**
/// - `min` (int): The minimum required length
/// - `length` (int): The actual length of the map
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.minLength) {
///   final min = issue?.params?[ValityParams.min] as int?;
///   print('Minimum map length required: $min');
/// }
/// ```
ValityRule<Map<K, V>?> minLengthMap<K, V>(int min) =>
    minLength<Map<K, V>?>(min, (value) => value?.length ?? 0);

/// Validates that a Map has maximum length
///
/// **Error Code:** `ValityRuleBase.maxLength`
///
/// **Parameters:**
/// - `max` (int): The maximum allowed length
/// - `length` (int): The actual length of the map
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.maxLength) {
///   final max = issue?.params?[ValityParams.max] as int?;
///   print('Maximum map length allowed: $max');
/// }
/// ```
ValityRule<Map<K, V>?> maxLengthMap<K, V>(int max) =>
    maxLength<Map<K, V>?>(max, (value) => value?.length ?? 0);

// ============================================================================
// Map Content Validators
// ============================================================================

/// Validates that a Map contains a specific key
ValityRule<Map<K, V>?> containsKey<K, V>(K key) =>
    (value) => value == null || !value.containsKey(key)
        ? ValityIssue(code: ValityRuleBase.containsKey)
        : null;

/// Validates that a Map contains a specific value
ValityRule<Map<K, V>?> containsValue<K, V>(V val) =>
    (value) => value == null || !value.containsValue(val)
        ? ValityIssue(code: ValityRuleBase.containsValue)
        : null;
