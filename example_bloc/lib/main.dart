import 'package:example_bloc/l10n/app_localizations.dart';
import 'package:example_bloc/login_cubit/login_cubit.dart';
import 'package:example_bloc/localization/vality_localizations.dart';
import 'package:example_bloc/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(LoginState())),
        BlocProvider(create: (context) => RegisterCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // Setup localization
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', ''), Locale('id', '')],
        home: const LoginPage(),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Username Field
                TextFormField(
                  initialValue: state.username.value,
                  onChanged: (value) => cubit.updateUsername(value),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    errorText: state.username.errorMessage(context),
                  ),
                ),
                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  initialValue: state.email.value,
                  onChanged: (value) => cubit.updateEmail(value),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: state.email.errorMessage(context),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  initialValue: state.password.value,
                  onChanged: (value) => cubit.updatePassword(value),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: state.password.errorMessage(context),
                  ),
                ),
                const SizedBox(height: 16),

                // Re-Password Field
                TextFormField(
                  initialValue: state.rePassword.value,
                  onChanged: (value) => cubit.updateRePassword(value),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    errorText: state.rePassword.errorMessage(context),
                  ),
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isValid ? () => cubit.submit() : null,
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      body: Column(
        children: [
          Text('Login'),
          TextFormField(
            initialValue: cubit.state.email,
            onChanged: (value) => cubit.updateEmail(value),
            decoration: InputDecoration(labelText: 'Email'),
            validator: (_) => cubit.state.emailError,
          ),
          TextFormField(
            initialValue: cubit.state.password,
            onChanged: (value) => cubit.updatePassword(value),
            validator: (_) => cubit.state.passwordError,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          ElevatedButton(onPressed: () {}, child: Text('Login')),
        ],
      ),
    );
  }
}

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void submit() {
//     LoginRepo().login(emailController.text, passwordController.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Text('Login'),
//           TextField(
//             controller: emailController,
//             decoration: InputDecoration(
//               labelText: 'Email',
//             ),
//           ),
//           TextField(
//             controller: passwordController,
//             decoration: InputDecoration(
//               labelText: 'Password',
//             ),
//           ),
//           ElevatedButton(onPressed: () {}, child: Text('Login'))
//         ],
//       ),
//     );
//   }
// }
