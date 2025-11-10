part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String email;
  final String? emailError;

  final String password;
  final String? passwordError;

  // Example if it is register page
  final String name;
  final String nameError;
  final String gender;
  final String genderError;
  final String dob;
  final String dobError;

  const LoginState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.name = '',
    this.nameError = '',
    this.gender = '',
    this.genderError = '',
    this.dob = '',
    this.dobError = '',
  });

  @override
  List<Object?> get props => [
    email,
    password,
    emailError,
    passwordError,
    name,
    nameError,
    gender,
    genderError,
    dob,
    dobError,
  ];

  LoginState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    String? name,
    String? nameError,
    String? gender,
    String? genderError,
    String? dob,
    String? dobError,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      name: name ?? this.name,
      nameError: nameError ?? this.nameError,
      gender: gender ?? this.gender,
      genderError: genderError ?? this.genderError,
      dob: dob ?? this.dob,
      dobError: dobError ?? this.dobError,
    );
  }
}
