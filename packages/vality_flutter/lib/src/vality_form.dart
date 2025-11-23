import 'package:flutter/widgets.dart';
import 'package:vality_flutter/src/vality_form_state.dart';

class ValityForm<T extends ValityFormState<T>> extends StatefulWidget {
  final Widget child;
  final T initialState;
  const ValityForm({
    super.key,
    required this.child,
    required this.initialState,
  });

  static ValityScope<T> of<T extends ValityFormState<T>>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ValityScope<T>>()!;
  }

  @override
  State<ValityForm<T>> createState() => _ValityFormState<T>();
}

class _ValityFormState<T extends ValityFormState<T>>
    extends State<ValityForm<T>> {
  late T _state;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _state = widget.initialState;
  }

  void _setFormState(T state) {
    _state = state;
    setState(() {});
  }

  void _validateForm() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return ValityScope(
      state: _state,
      setState: _setFormState,
      validate: _validateForm,
      child: Form(key: _formKey, child: widget.child),
    );
  }
}

class ValityScope<T extends ValityFormState<T>> extends InheritedWidget {
  final T state;
  final void Function(T) setState;
  final void Function() validate;
  const ValityScope({
    super.key,
    required super.child,
    required this.state,
    required this.setState,
    required this.validate,
  });

  @override
  bool updateShouldNotify(ValityScope oldWidget) {
    return state != oldWidget.state;
  }
}

extension ValityFormExtension on BuildContext {
  ValityScope<T> valityScope<T extends ValityFormState<T>>() {
    return ValityForm.of<T>(this);
  }
}
