// import 'package:flutter/material.dart';
// import 'package:vality/vality.dart';

// // ============================================================================
// // Validation Schemas
// // ============================================================================

// final usernameScheme = ValitySchema<String?>()
//     .add(notNull())
//     .add(notEmpty())
//     .add(minLengthString(3))
//     .add(maxLengthString(20))
//     .add(alphanumeric());

// final emailScheme =
//     ValitySchema<String?>().add(notNull()).add(notEmpty()).add(email());

// final passwordScheme = ValitySchema<String?>()
//     .add(notNull())
//     .add(notEmpty())
//     .add(minLengthString(8))
//     .add(maxLengthString(50))
//     .add(containsUpperCase(1))
//     .add(containsLowerCase(1))
//     .add(containsNumbers(2))
//     .add(containsSpecialChar(1));

// // ============================================================================
// // Custom Field Classes
// // ============================================================================

// class UsernameField extends ValityField<String?> {
//   UsernameField({required super.value, super.issue})
//       : super(schema: usernameScheme);

//   @override
//   UsernameField copyWith({required String? value}) {
//     return UsernameField(value: value, issue: schema.validate(value));
//   }
// }

// class EmailField extends ValityField<String?> {
//   EmailField({required super.value, super.issue}) : super(schema: emailScheme);

//   @override
//   EmailField copyWith({required String? value}) {
//     return EmailField(value: value, issue: schema.validate(value));
//   }
// }

// class PasswordField extends ValityField<String?> {
//   PasswordField({required super.value, super.issue})
//       : super(schema: passwordScheme);

//   @override
//   PasswordField copyWith({required String? value}) {
//     return PasswordField(value: value, issue: schema.validate(value));
//   }
// }

// class RePasswordField extends ValityField<String?> {
//   final String? passwordValue;

//   RePasswordField({
//     required super.value,
//     required this.passwordValue,
//     super.issue,
//   }) : super(schema: ValitySchema<String?>([notNull(), notEmpty()]));

//   @override
//   RePasswordField copyWith({required String? value, String? passwordValue}) {
//     final schemaIssue = schema.validate(value);
//     final matchIssue =
//         (value != null && passwordValue != null && value != passwordValue)
//             ? ValityIssue(code: 'passwordMismatch')
//             : null;
//     return RePasswordField(
//       value: value,
//       passwordValue: passwordValue ?? this.passwordValue,
//       issue: schemaIssue ?? matchIssue,
//     );
//   }
// }

// // ============================================================================
// // State Management
// // ============================================================================

// class RegisterFormState {
//   final UsernameField username;
//   final EmailField email;
//   final PasswordField password;
//   final RePasswordField rePassword;

//   const RegisterFormState({
//     required this.username,
//     required this.email,
//     required this.password,
//     required this.rePassword,
//   });

//   RegisterFormState copyWith({
//     UsernameField? username,
//     EmailField? email,
//     PasswordField? password,
//     RePasswordField? rePassword,
//   }) {
//     return RegisterFormState(
//       username: username ?? this.username,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       rePassword: rePassword ?? this.rePassword,
//     );
//   }

//   bool get isValid =>
//       username.isValid &&
//       email.isValid &&
//       password.isValid &&
//       rePassword.isValid;
// }

// // ============================================================================
// // Error Translation
// // ============================================================================

// String translateError(ValityIssue issue) {
//   switch (issue.code) {
//     case ValityRuleBase.notNull:
//       return 'This field is required';
//     case ValityRuleBase.notEmpty:
//       return 'This field cannot be empty';
//     case ValityRuleBase.minLength:
//       final min = issue.params?[ValityParams.min] as int?;
//       return 'Must be at least $min characters';
//     case ValityRuleBase.maxLength:
//       final max = issue.params?[ValityParams.max] as int?;
//       return 'Must be at most $max characters';
//     case ValityRuleBase.email:
//       return 'Please enter a valid email address';
//     case ValityRuleBase.alphanumeric:
//       return 'Only letters and numbers are allowed';
//     case ValityRuleBase.containsUpperCase:
//       final minCount = issue.params?[ValityParams.minCount] as int?;
//       return 'Must contain at least $minCount uppercase letter(s)';
//     case ValityRuleBase.containsLowerCase:
//       final minCount = issue.params?[ValityParams.minCount] as int?;
//       return 'Must contain at least $minCount lowercase letter(s)';
//     case ValityRuleBase.containsNumbers:
//       final minCount = issue.params?[ValityParams.minCount] as int?;
//       return 'Must contain at least $minCount number(s)';
//     case ValityRuleBase.containsSpecialChar:
//       final minCount = issue.params?[ValityParams.minCount] as int?;
//       return 'Must contain at least $minCount special character(s)';
//     case 'passwordMismatch':
//       return 'Passwords do not match';
//     default:
//       return 'Validation error';
//   }
// }

// // ============================================================================
// // Flutter Widget
// // ============================================================================

// class RegisterForm extends StatefulWidget {
//   const RegisterForm({super.key});

//   @override
//   State<RegisterForm> createState() => _RegisterFormState();
// }

// class _RegisterFormState extends State<RegisterForm> {
//   late RegisterFormState _state;

//   @override
//   void initState() {
//     super.initState();
//     _state = RegisterFormState(
//       username: UsernameField(value: ''),
//       email: EmailField(value: ''),
//       password: PasswordField(value: ''),
//       rePassword: RePasswordField(value: '', passwordValue: ''),
//     );
//   }

//   void _updateUsername(String? value) {
//     setState(() {
//       _state = _state.copyWith(
//         username: _state.username.copyWith(value: value),
//       );
//     });
//   }

//   void _updateEmail(String? value) {
//     setState(() {
//       _state = _state.copyWith(email: _state.email.copyWith(value: value));
//     });
//   }

//   void _updatePassword(String? value) {
//     setState(() {
//       _state = _state.copyWith(
//         password: _state.password.copyWith(value: value),
//         rePassword: _state.rePassword.copyWith(
//           value: _state.rePassword.value,
//           passwordValue: value,
//         ),
//       );
//     });
//   }

//   void _updateRePassword(String? value) {
//     setState(() {
//       _state = _state.copyWith(
//         rePassword: _state.rePassword.copyWith(
//           value: value,
//           passwordValue: _state.password.value,
//         ),
//       );
//     });
//   }

//   void _submit() {
//     if (!_state.isValid) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix validation errors')),
//       );
//       return;
//     }

//     // Form is valid, proceed with registration
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Registering: ${_state.username.value}'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Register')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             children: [
//               // Username Field
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Username',
//                   errorText: _state.username.issue != null
//                       ? translateError(_state.username.issue!)
//                       : null,
//                 ),
//                 onChanged: _updateUsername,
//               ),
//               const SizedBox(height: 16),

//               // Email Field
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   errorText: _state.email.issue != null
//                       ? translateError(_state.email.issue!)
//                       : null,
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 onChanged: _updateEmail,
//               ),
//               const SizedBox(height: 16),

//               // Password Field
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   errorText: _state.password.issue != null
//                       ? translateError(_state.password.issue!)
//                       : null,
//                 ),
//                 obscureText: true,
//                 onChanged: _updatePassword,
//               ),
//               const SizedBox(height: 16),

//               // Re-Password Field
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Confirm Password',
//                   errorText: _state.rePassword.issue != null
//                       ? translateError(_state.rePassword.issue!)
//                       : null,
//                 ),
//                 obscureText: true,
//                 onChanged: _updateRePassword,
//               ),
//               const SizedBox(height: 24),

//               // Submit Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _submit,
//                   child: const Text('Register'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ============================================================================
// // Main App
// // ============================================================================

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Register Form Example',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const RegisterForm(),
//     );
//   }
// }
