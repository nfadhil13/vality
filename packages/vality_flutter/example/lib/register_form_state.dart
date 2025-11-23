import 'package:example/schemas.dart';
import 'package:vality/vality.dart';
import 'package:vality_flutter/vality_flutter.dart';

class RegisterFormState extends ValityFormState<RegisterFormState> {
  final ValityField<String?> name;
  final ValityField<String?> email;
  final PasswordField password;
  final ConfirmPasswordField confirmPassword;

  const RegisterFormState({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  RegisterFormState.initial({
    String name = '',
    String email = '',
    String password = '',
    String confirmPassword = '',
  }) : name = nameSchema.asField(name),
       email = emailSchema.asField(email),
       password = PasswordField(value: password),
       confirmPassword = ConfirmPasswordField(value: confirmPassword);

  @override
  RegisterFormState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterFormState(
      name: this.name.copyWith(value: name),
      email: this.email.copyWith(value: email),
      password: this.password.copyWith(value: password),
      confirmPassword: this.confirmPassword.copyWith(value: confirmPassword),
    );
  }

  @override
  List<ValityField> get fields => [name, email, password, confirmPassword];
}
