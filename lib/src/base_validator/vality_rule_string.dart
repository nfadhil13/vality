part of vality_rule_base;

// ============================================================================
// String Length Validators
// ============================================================================

/// Validates that a String is not empty
ValityRule<String?> notEmpty() => (value) => value == null || value.isEmpty
    ? ValityIssue(code: ValityRuleBase.notEmpty)
    : null;

/// Validates that a String has minimum length
///
/// **Error Code:** `ValityRuleBase.minLength`
///
/// **Parameters:**
/// - `min` (int): The minimum required length
/// - `length` (int): The actual length of the string
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.minLength) {
///   final min = issue?.params?[ValityParams.min] as int?;
///   print('Minimum length required: $min');
/// }
/// ```
ValityRule<String?> minLengthString(int min) =>
    minLength<String?>(min, (value) => value?.length ?? 0);

/// Validates that a String has maximum length
///
/// **Error Code:** `ValityRuleBase.maxLength`
///
/// **Parameters:**
/// - `max` (int): The maximum allowed length
/// - `length` (int): The actual length of the string
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.maxLength) {
///   final max = issue?.params?[ValityParams.max] as int?;
///   print('Maximum length allowed: $max');
/// }
/// ```
ValityRule<String?> maxLengthString(int max) =>
    maxLength<String?>(max, (value) => value?.length ?? 0);

// ============================================================================
// String Format Validators
// ============================================================================

/// Validates that a String is a valid email address
ValityRule<String?> email() {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return (value) =>
      value == null || value.isEmpty || !emailRegex.hasMatch(value)
          ? ValityIssue(code: ValityRuleBase.email)
          : null;
}

/// Validates that a String is a valid URL
ValityRule<String?> url() {
  final urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  );
  return (value) => value == null || value.isEmpty || !urlRegex.hasMatch(value)
      ? ValityIssue(code: ValityRuleBase.url)
      : null;
}

/// Validates that a String contains a substring
///
/// **Error Code:** `ValityRuleBase.contains`
///
/// **Parameters:**
/// - `substring` (String): The substring that must be contained
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.contains) {
///   final substring = issue?.params?[ValityParams.substring] as String?;
///   print('Must contain: $substring');
/// }
/// ```
ValityRule<String?> containsString(String substring) =>
    (value) => value == null || !value.contains(substring)
        ? ValityIssue(
            code: ValityRuleBase.contains,
            params: {ValityParams.substring: substring},
          )
        : null;

/// Validates that a String contains at least N occurrences of a substring
/// Useful for password validation like "contains at least one special character"
///
/// **Error Code:** `ValityRuleBase.containsNofString`
///
/// **Parameters:**
/// - `substring` (String): The substring to search for
/// - `minCount` (int): The minimum number of occurrences required
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.containsNofString) {
///   final substring = issue?.params?[ValityParams.substring] as String?;
///   final minCount = issue?.params?[ValityParams.minCount] as int?;
///   print('Must contain at least $minCount occurrence(s) of: $substring');
/// }
/// ```
ValityRule<String?> containsNofString(String substring, int minCount) =>
    (value) {
      if (value == null || value.isEmpty) {
        return ValityIssue(
          code: ValityRuleBase.containsNofString,
          params: {ValityParams.substring: substring, ValityParams.minCount: minCount},
        );
      }
      int count = 0;
      int index = 0;
      while ((index = value.indexOf(substring, index)) != -1) {
        count++;
        index += substring.length;
      }
      return count < minCount
          ? ValityIssue(
              code: ValityRuleBase.containsNofString,
              params: {ValityParams.substring: substring, ValityParams.minCount: minCount},
            )
          : null;
    };

/// Validates that a String contains at least N matches of a regex pattern
/// Useful for password validation like "contains at least 2 numbers"
///
/// **Error Code:** `ValityRuleBase.containsNofRegex`
///
/// **Parameters:**
/// - `minCount` (int): The minimum number of matches required
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.containsNofRegex) {
///   final minCount = issue?.params?[ValityParams.minCount] as int?;
///   print('Must contain at least $minCount match(es)');
/// }
/// ```
ValityRule<String?> containsNofRegex(RegExp pattern, int minCount) => (value) {
      if (value == null || value.isEmpty) {
        return ValityIssue(
          code: ValityRuleBase.containsNofRegex,
          params: {ValityParams.minCount: minCount},
        );
      }
      final matches = pattern.allMatches(value);
      return matches.length < minCount
          ? ValityIssue(
              code: ValityRuleBase.containsNofRegex,
              params: {ValityParams.minCount: minCount},
            )
          : null;
    };

// ============================================================================
// Character Type Validators (semantic helpers)
// ============================================================================

/// Validates that a String contains at least N uppercase letters
/// Defaults to 1 if minCount is not specified
///
/// **Error Code:** `ValityRuleBase.containsUpperCase`
///
/// **Parameters:**
/// - `minCount` (int): The minimum number of uppercase letters required
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.containsUpperCase) {
///   final minCount = issue?.params?[ValityParams.minCount] as int?;
///   print('Required at least $minCount uppercase letter(s)');
/// }
/// ```
ValityRule<String?> containsUpperCase([int minCount = 1]) => (value) {
      if (value == null || value.isEmpty) {
        return ValityIssue(
          code: ValityRuleBase.containsUpperCase,
          params: {ValityParams.minCount: minCount},
        );
      }
      final pattern = RegExp(ValityRegex.upperCase);
      final matches = pattern.allMatches(value);
      return matches.length < minCount
          ? ValityIssue(
              code: ValityRuleBase.containsUpperCase,
              params: {ValityParams.minCount: minCount},
            )
          : null;
    };

/// Validates that a String contains at least N lowercase letters
/// Defaults to 1 if minCount is not specified
///
/// **Error Code:** `ValityRuleBase.containsLowerCase`
///
/// **Parameters:**
/// - `minCount` (int): The minimum number of lowercase letters required
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.containsLowerCase) {
///   final minCount = issue?.params?[ValityParams.minCount] as int?;
///   print('Required at least $minCount lowercase letter(s)');
/// }
/// ```
ValityRule<String?> containsLowerCase([int minCount = 1]) => (value) {
      if (value == null || value.isEmpty) {
        return ValityIssue(
          code: ValityRuleBase.containsLowerCase,
          params: {ValityParams.minCount: minCount},
        );
      }
      final pattern = RegExp(ValityRegex.lowerCase);
      final matches = pattern.allMatches(value);
      return matches.length < minCount
          ? ValityIssue(
              code: ValityRuleBase.containsLowerCase,
              params: {ValityParams.minCount: minCount},
            )
          : null;
    };

/// Validates that a String contains at least N numbers
/// Defaults to 1 if minCount is not specified
///
/// **Error Code:** `ValityRuleBase.containsNumbers`
///
/// **Parameters:**
/// - `minCount` (int): The minimum number of digits required
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.containsNumbers) {
///   final minCount = issue?.params?[ValityParams.minCount] as int?;
///   print('Required at least $minCount number(s)');
/// }
/// ```
ValityRule<String?> containsNumbers([int minCount = 1]) => (value) {
      if (value == null || value.isEmpty) {
        return ValityIssue(
          code: ValityRuleBase.containsNumbers,
          params: {ValityParams.minCount: minCount},
        );
      }
      final pattern = RegExp(ValityRegex.numbers);
      final matches = pattern.allMatches(value);
      return matches.length < minCount
          ? ValityIssue(
              code: ValityRuleBase.containsNumbers,
              params: {ValityParams.minCount: minCount},
            )
          : null;
    };

/// Validates that a String contains at least N special characters
/// Defaults to 1 if minCount is not specified
///
/// **Error Code:** `ValityRuleBase.containsSpecialChar`
///
/// **Parameters:**
/// - `minCount` (int): The minimum number of special characters required
///
/// **Example:**
/// ```dart
/// if (issue?.code == ValityRuleBase.containsSpecialChar) {
///   final minCount = issue?.params?[ValityParams.minCount] as int?;
///   print('Required at least $minCount special character(s)');
/// }
/// ```
ValityRule<String?> containsSpecialChar([int minCount = 1]) => (value) {
      if (value == null || value.isEmpty) {
        return ValityIssue(
          code: ValityRuleBase.containsSpecialChar,
          params: {ValityParams.minCount: minCount},
        );
      }
      final pattern = RegExp(ValityRegex.specialChar);
      final matches = pattern.allMatches(value);
      return matches.length < minCount
          ? ValityIssue(
              code: ValityRuleBase.containsSpecialChar,
              params: {ValityParams.minCount: minCount},
            )
          : null;
    };

/// Validates that a String starts with a prefix
ValityRule<String?> startsWithString(String prefix) =>
    (value) => value == null || !value.startsWith(prefix)
        ? ValityIssue(code: ValityRuleBase.startsWith)
        : null;

/// Validates that a String ends with a suffix
ValityRule<String?> endsWithString(String suffix) =>
    (value) => value == null || !value.endsWith(suffix)
        ? ValityIssue(code: ValityRuleBase.endsWith)
        : null;

/// Validates that a String matches a regular expression
ValityRule<String?> matchesPattern(RegExp pattern) =>
    (value) => value == null || !pattern.hasMatch(value)
        ? ValityIssue(code: ValityRuleBase.matches)
        : null;

/// Validates that a String contains only alphanumeric characters
ValityRule<String?> alphanumeric() {
  final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
  return (value) =>
      value == null || value.isEmpty || !alphanumericRegex.hasMatch(value)
          ? ValityIssue(code: ValityRuleBase.alphanumeric)
          : null;
}

/// Validates that a String contains only numeric characters
ValityRule<String?> numeric() {
  final numericRegex = RegExp(r'^[0-9]+$');
  return (value) =>
      value == null || value.isEmpty || !numericRegex.hasMatch(value)
          ? ValityIssue(code: ValityRuleBase.numeric)
          : null;
}
