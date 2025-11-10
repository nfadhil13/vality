import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:example_bloc/repo.dart';
import 'package:vality/vality.dart';

part 'my_register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit()
    : super(
        RegisterState(
          name: NameField(value: ''),
          email: ValityField<String>(
            value: '',
            schema: ValitySchema([notEmpty(), email()]),
          ),
          password: ValityField(
            value: '',
            schema: ValitySchema([notEmpty(), minLength(8), maxLength(20)]),
          ),
        ),
      );

  final auth = AuthRepo();

  void submit() {
    auth.login(state.email.value, state.password.value);
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: state.email.copyWith(value: email)));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: state.password.copyWith(value: password)));
  }

  void updateName(String name) {
    emit(state.copyWith(name: state.name.copyWith(value: name)));
  }
}
