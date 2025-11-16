import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:example_bloc/repo.dart';
import 'package:vality/vality.dart';

part 'my_register_state.dart';

// ============================================================================
// Validation Schemas
// ============================================================================

/// Username validation schema
/// - Not null
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
final emailScheme = ValitySchema<String?>()
    .add(notNull())
    .add(notEmpty())
    .add(email());

/// Password validation schema
/// - Not null
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
    .add(containsUpperCase())
    .add(containsLowerCase())
    .add(containsNumbers())
    .add(containsSpecialChar());

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit()
    : super(
        RegisterState(
          username: UsernameField(value: ''),
          email: EmailField(value: ''),
          password: PasswordField(value: ''),
          rePassword: RePasswordField(value: '', passwordValue: ''),
        ),
      );

  final auth = AuthRepo();

  void submit() {
    if (!state.isValid) {
      // Form has validation errors, handle them
      return;
    }

    // All fields are valid, proceed with registration
    auth.register(
      state.username.value ?? '',
      state.email.value ?? '',
      state.password.value ?? '',
    );
  }

  void updateUsername(String? username) {
    emit(state.copyWith(username: state.username.copyWith(value: username)));
  }

  void updateEmail(String? email) {
    emit(state.copyWith(email: state.email.copyWith(value: email)));
  }

  void updatePassword(String? password) {
    emit(
      state.copyWith(
        password: state.password.copyWith(value: password),
        rePassword: state.rePassword.copyWith(
          value: state.rePassword.value,
          passwordValue: password,
        ),
      ),
    );
  }

  void updateRePassword(String? rePassword) {
    emit(
      state.copyWith(
        rePassword: state.rePassword.copyWith(
          value: rePassword,
          passwordValue: state.password.value,
        ),
      ),
    );
  }
}
