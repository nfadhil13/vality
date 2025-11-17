import 'package:vality/vality.dart';

// ============================================================================
// Validation Schemas
// ============================================================================

/// Username validation schema
/// - Not empty
/// - 3-20 characters
/// - Alphanumeric only
final usernameScheme = ValitySchema<String?>()
    .add(notNull())
    .add(notEmpty())
    .add(minLengthString(3))
    .add(maxLengthString(20))
    .add(alphanumeric());

/// Email validation schema
/// - Not null
/// - Not empty
/// - Valid email format
final emailScheme =
    ValitySchema<String?>().add(notNull()).add(notEmpty()).add(email());

/// Password validation schema
/// - Not empty
/// - 8-50 characters
/// - Contains at least 1 uppercase letter
/// - Contains at least 1 lowercase letter
/// - Contains at least 2 numbers
/// - Contains at least 1 special character
final passwordScheme = ValitySchema<String?>()
    .add(notNull())
    .add(notEmpty())
    .add(minLengthString(8))
    .add(maxLengthString(50))
    .add(containsUpperCase(1))
    .add(containsLowerCase(1))
    .add(containsNumbers(2))
    .add(containsSpecialChar(1));

// ============================================================================
// Custom Field Classes
// ============================================================================

/// Username field with validation
class UsernameField extends ValityField<String?> {
  UsernameField({required super.value, super.issue})
      : super(schema: usernameScheme);

  @override
  UsernameField copyWith({required String? value}) {
    final issue = schema.validate(value);
    return UsernameField(value: value, issue: issue);
  }
}

/// Email field with validation
class EmailField extends ValityField<String?> {
  EmailField({required super.value, super.issue}) : super(schema: emailScheme);

  @override
  EmailField copyWith({required String? value}) {
    final issue = schema.validate(value);
    return EmailField(value: value, issue: issue);
  }
}

/// Password field with validation
class PasswordField extends ValityField<String?> {
  PasswordField({required super.value, super.issue})
      : super(schema: passwordScheme);

  @override
  PasswordField copyWith({required String? value}) {
    final issue = schema.validate(value);
    return PasswordField(value: value, issue: issue);
  }
}

/// Re-password field with validation
/// Must match the password field
class RePasswordField extends ValityField<String?> {
  final String? passwordValue;

  RePasswordField({
    required super.value,
    required this.passwordValue,
    super.issue,
  }) : super(
          schema: ValitySchema<String?>([
            notNull(),
            notEmpty(),
          ]),
        );

  /// Custom validation: check if rePassword matches password
  ValityIssue? _validatePasswordMatch(String? value) {
    if (value == null || passwordValue == null) {
      return null; // Let notNull/notEmpty handle this
    }
    if (value != passwordValue) {
      return ValityIssue(code: 'passwordMismatch');
    }
    return null;
  }

  @override
  RePasswordField copyWith({
    required String? value,
    String? passwordValue,
  }) {
    // First validate against schema
    final schemaIssue = schema.validate(value);

    // Then validate password match
    final matchIssue = _validatePasswordMatch(value);

    // Return the first issue found
    final issue = schemaIssue ?? matchIssue;

    return RePasswordField(
      value: value,
      passwordValue: passwordValue ?? this.passwordValue,
      issue: issue,
    );
  }
}

// ============================================================================
// Register Form State
// ============================================================================

class RegisterFormState {
  final UsernameField username;
  final EmailField email;
  final PasswordField password;
  final RePasswordField rePassword;

  const RegisterFormState({
    required this.username,
    required this.email,
    required this.password,
    required this.rePassword,
  });

  RegisterFormState copyWith({
    UsernameField? username,
    EmailField? email,
    PasswordField? password,
    RePasswordField? rePassword,
  }) {
    return RegisterFormState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
    );
  }

  /// Check if all fields are valid
  bool get isValid =>
      username.isValid &&
      email.isValid &&
      password.isValid &&
      rePassword.isValid;

  /// Get all validation errors
  List<ValityIssue> get errors {
    final issues = <ValityIssue>[];
    if (username.issue != null) issues.add(username.issue!);
    if (email.issue != null) issues.add(email.issue!);
    if (password.issue != null) issues.add(password.issue!);
    if (rePassword.issue != null) issues.add(rePassword.issue!);
    return issues;
  }
}

// ============================================================================
// Register Form Controller (Cubit/Bloc pattern)
// ============================================================================

class RegisterFormController {
  RegisterFormState _state = RegisterFormState(
    username: UsernameField(value: ''),
    email: EmailField(value: ''),
    password: PasswordField(value: ''),
    rePassword: RePasswordField(value: '', passwordValue: ''),
  );

  RegisterFormState get state => _state;

  /// Update username field
  void updateUsername(String? username) {
    _state = _state.copyWith(
      username: _state.username.copyWith(value: username),
    );
  }

  /// Update email field
  void updateEmail(String? email) {
    _state = _state.copyWith(
      email: _state.email.copyWith(value: email),
    );
  }

  /// Update password field
  /// Also updates rePassword to re-validate match
  void updatePassword(String? password) {
    _state = _state.copyWith(
      password: _state.password.copyWith(value: password),
      rePassword: _state.rePassword.copyWith(
        value: _state.rePassword.value,
        passwordValue: password,
      ),
    );
  }

  /// Update re-password field
  void updateRePassword(String? rePassword) {
    _state = _state.copyWith(
      rePassword: _state.rePassword.copyWith(
        value: rePassword,
        passwordValue: _state.password.value,
      ),
    );
  }

  /// Submit the form
  void submit() {
    if (!_state.isValid) {
      print('Form has validation errors:');
      for (final error in _state.errors) {
        print('  - ${error.code}');
      }
      return;
    }

    // All fields are valid, proceed with registration
    print('Registering user:');
    print('  Username: ${_state.username.value}');
    print('  Email: ${_state.email.value}');
    print('  Password: ${'*' * (_state.password.value?.length ?? 0)}');
  }
}

// ============================================================================
// Error Translation Helper (Example)
// ============================================================================

/// Example translation function
/// In a real app, this would use flutter_localizations or similar
String translateValityIssue(ValityIssue issue) {
  switch (issue.code) {
    // Common errors
    case ValityRuleBase.notNull:
      return 'This field is required';
    case ValityRuleBase.notEmpty:
      return 'This field cannot be empty';

    // Length errors
    case ValityRuleBase.minLength:
      final min = issue.params?[ValityParams.min] as int?;
      return 'Must be at least $min characters';
    case ValityRuleBase.maxLength:
      final max = issue.params?[ValityParams.max] as int?;
      return 'Must be at most $max characters';

    // Email errors
    case ValityRuleBase.email:
      return 'Please enter a valid email address';

    // Alphanumeric errors
    case ValityRuleBase.alphanumeric:
      return 'Only letters and numbers are allowed';

    // Password character requirements
    case ValityRuleBase.containsUpperCase:
      final minCount = issue.params?[ValityParams.minCount] as int?;
      return 'Must contain at least $minCount uppercase letter(s)';
    case ValityRuleBase.containsLowerCase:
      final minCount = issue.params?[ValityParams.minCount] as int?;
      return 'Must contain at least $minCount lowercase letter(s)';
    case ValityRuleBase.containsNumbers:
      final minCount = issue.params?[ValityParams.minCount] as int?;
      return 'Must contain at least $minCount number(s)';
    case ValityRuleBase.containsSpecialChar:
      final minCount = issue.params?[ValityParams.minCount] as int?;
      return 'Must contain at least $minCount special character(s)';

    // Custom errors
    case 'passwordMismatch':
      return 'Passwords do not match';

    // Default
    default:
      return 'Validation error: ${issue.code}';
  }
}

// ============================================================================
// Usage Example
// ============================================================================

void main() {
  final controller = RegisterFormController();

  // Simulate user input
  print('=== Testing Username ===');
  controller.updateUsername('ab'); // Too short
  print('Username: "${controller.state.username.value}"');
  print('Valid: ${controller.state.username.isValid}');
  if (controller.state.username.issue != null) {
    print('Error: ${translateValityIssue(controller.state.username.issue!)}');
  }

  controller.updateUsername('user123'); // Valid
  print('Username: "${controller.state.username.value}"');
  print('Valid: ${controller.state.username.isValid}');
  print('');

  print('=== Testing Email ===');
  controller.updateEmail('invalid-email'); // Invalid format
  print('Email: "${controller.state.email.value}"');
  print('Valid: ${controller.state.email.isValid}');
  if (controller.state.email.issue != null) {
    print('Error: ${translateValityIssue(controller.state.email.issue!)}');
  }

  controller.updateEmail('user@example.com'); // Valid
  print('Email: "${controller.state.email.value}"');
  print('Valid: ${controller.state.email.isValid}');
  print('');

  print('=== Testing Password ===');
  controller.updatePassword('weak'); // Too weak
  print('Password: "${controller.state.password.value}"');
  print('Valid: ${controller.state.password.isValid}');
  if (controller.state.password.issue != null) {
    print('Error: ${translateValityIssue(controller.state.password.issue!)}');
  }

  controller.updatePassword('StrongP@ss123'); // Valid
  print('Password: "${controller.state.password.value}"');
  print('Valid: ${controller.state.password.isValid}');
  print('');

  print('=== Testing Re-Password ===');
  controller.updateRePassword('Different123'); // Doesn't match
  print('RePassword: "${controller.state.rePassword.value}"');
  print('Valid: ${controller.state.rePassword.isValid}');
  if (controller.state.rePassword.issue != null) {
    print('Error: ${translateValityIssue(controller.state.rePassword.issue!)}');
  }

  controller.updateRePassword('StrongP@ss123'); // Matches
  print('RePassword: "${controller.state.rePassword.value}"');
  print('Valid: ${controller.state.rePassword.isValid}');
  print('');

  print('=== Form Validation ===');
  print('All fields valid: ${controller.state.isValid}');
  controller.submit();
}
