import 'package:example/register_form_state.dart';
import 'package:flutter/material.dart';
import 'package:vality/vality.dart';
import 'package:vality_flutter/vality_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        body: ValityForm(
          initialState: RegisterFormState.initial(),
          child: FormBody(),
        ),
      ),
    );
  }
}

class FormBody extends StatelessWidget {
  const FormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.valityScope<RegisterFormState>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: form.state.name.value,
              onChanged: (value) =>
                  form.setState(form.state.copyWith(name: value)),
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: form.state.name.issue?.code,
              ),
            ),
            TextFormField(
              initialValue: form.state.email.value,
              onChanged: (value) =>
                  form.setState(form.state.copyWith(email: value)),
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: form.state.email.issue?.code,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
