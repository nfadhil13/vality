/// Collection of reusable regex patterns for validation
/// All patterns are stored as strings. Use RegExp(pattern) to create a RegExp instance.
class ValityRegex {
  ValityRegex._(); // coverage:ignore-line

  // ============================================================================
  // Character Type Patterns (for password validation, etc.)
  // ============================================================================

  /// Matches uppercase letters (A-Z)
  static const String upperCase = r'[A-Z]';

  /// Matches lowercase letters (a-z)
  static const String lowerCase = r'[a-z]';

  /// Matches numbers (0-9)
  static const String numbers = r'[0-9]';

  /// Matches special characters
  /// Includes: !@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?
  static const String specialChar =
      '[!@#\$%^&*()_+\\-=\\[\\]{};\':"\\\\|,.<>\\/?]';

  // ============================================================================
  // Format Patterns (for complete string validation)
  // ============================================================================

  /// Matches a valid email address
  static const String email =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  /// Matches a valid URL
  static const String url =
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';

  /// Matches only alphanumeric characters (letters and numbers)
  static const String alphanumeric = r'^[a-zA-Z0-9]+$';

  /// Matches only numeric characters (0-9)
  static const String numeric = r'^[0-9]+$';

  /// Matches only letters (uppercase and lowercase)
  static const String letters = r'^[a-zA-Z]+$';

  /// Matches only uppercase letters
  static const String onlyUpperCase = r'^[A-Z]+$';

  /// Matches only lowercase letters
  static const String onlyLowerCase = r'^[a-z]+$';
}
