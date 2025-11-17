import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:example_bloc/repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(super.initialState);

  final loginRepo = AuthRepo();

  void submit() {
    loginRepo.login(state.email, state.password);
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email, emailError: validateEmail(email)));
  }

  String? validateEmail(String email) {
    if (email.isEmpty) return "Email is required";
    if (!email.contains('@')) return "Email is invalid";
    return null;
  }

  void updatePassword(String password) {
    emit(state.copyWith(
        password: password, passwordError: validatePassword(password)));
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return "Password is required";
    if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }

  void updateName(String name) {}

  void validateName(String name) {}
}
