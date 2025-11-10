part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final ValityField<String> email;
  final ValityField<String> password;
  final NameField name;

  const RegisterState({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];

  RegisterState copyWith({
    NameField? name,
    ValityField<String>? email,
    ValityField<String>? password,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }
}

class NameField extends BaseValityField<String, NameField> {
  NameField({required super.value})
    : super(schema: ValitySchema([notEmpty(), minLength(3), maxLength(20)]));

  const NameField._({
    required super.value,
    required super.schema,
    required super.issue,
  });

  @override
  NameField newInstance(
    String value,
    ValitySchema<String> schema,
    ValityIssue? issue,
  ) => NameField._(value: value, schema: schema, issue: issue);
}
