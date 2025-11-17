part of 'register_cubit.dart';

// ============================================================================
// Register State
// ============================================================================

class RegisterState extends Equatable {
  final UsernameField username;
  final EmailField email;
  final PasswordField password;
  final RePasswordField rePassword;

  const RegisterState({
    required this.username,
    required this.email,
    required this.password,
    required this.rePassword,
  });

  @override
  List<Object?> get props => [username, email, password, rePassword];

  RegisterState copyWith({
    UsernameField? username,
    EmailField? email,
    PasswordField? password,
    RePasswordField? rePassword,
  }) {
    return RegisterState(
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
}

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
    : super(schema: passwordSchema);

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
  }) : super(schema: ValitySchema<String?>([notNull(), notEmpty()]));

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
  RePasswordField copyWith({required String? value, String? passwordValue}) {
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
