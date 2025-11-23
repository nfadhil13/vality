import 'package:vality/vality.dart';

final nameSchema = ValitySchema<String?>()
    .add(notNull())
    .add(notEmpty())
    .add(minLengthString(3))
    .add(maxLengthString(20));

final emailSchema = ValitySchema<String?>()
    .add(notNull())
    .add(notEmpty())
    .add(email());

final passwordSchema = ValitySchema<String?>()
    .add(notNull())
    .add(notEmpty())
    .add(minLengthString(8))
    .add(maxLengthString(50))
    .add(containsUpperCase(1))
    .add(containsLowerCase(1))
    .add(containsNumbers(2))
    .add(containsSpecialChar(1));

class PasswordField extends ValityField<String?> {
  PasswordField({required super.value, super.issue})
    : super(schema: passwordSchema);

  @override
  PasswordField copyWith({required String? value}) {
    final issue = schema.validate(value);
    return PasswordField(value: value, issue: issue);
  }

  @override
  List<Object?> get props => [value, issue];
}

class ConfirmPasswordField extends ValityField<String?> {
  final String? passwordValue;

  ConfirmPasswordField({
    required super.value,
    this.passwordValue = '',
    super.issue,
  }) : super(schema: passwordSchema);

  ValityRule<String?> _validatePasswordMatch(String? password) => (value) {
    if (value == null || passwordValue == null) {
      return null;
    }
    if (value != passwordValue) {
      return ValityIssue(code: 'passwordMismatch');
    }
    return null;
  };

  @override
  ConfirmPasswordField copyWith({
    required String? value,
    String? passwordValue,
  }) {
    final issue = schema
        .add(_validatePasswordMatch(passwordValue))
        .validate(value);
    return ConfirmPasswordField(
      value: value,
      issue: issue,
      passwordValue: passwordValue,
    );
  }
}
