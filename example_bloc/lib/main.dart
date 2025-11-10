import 'package:example_bloc/login_cubit/login_cubit.dart';
import 'package:example_bloc/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Column(
        children: [
          Text('Register'),
          TextFormField(
            initialValue: cubit.state.email.value,
            onChanged: (value) => cubit.updateEmail(value),
            decoration: InputDecoration(labelText: 'Email'),
            validator: (_) => cubit.state.email.issue?.code,
          ),
          TextFormField(
            initialValue: cubit.state.password.value,
            onChanged: (value) => cubit.updatePassword(value),
            validator: (_) => cubit.state.password.issue?.code,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          ElevatedButton(onPressed: () {}, child: Text('Login')),
        ],
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
