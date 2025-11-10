import 'package:equatable/equatable.dart';
import 'package:vality/src/vality_issue.dart';
import 'package:vality/src/vality_scheme.dart';

abstract class BaseValityField<T, Self extends BaseValityField<T, Self>>
    extends Equatable {
  final T value;
  final ValitySchema<T> schema;
  final ValityIssue? issue;

  const BaseValityField(
      {required this.value, required this.schema, this.issue});

  bool get isValid => issue == null;

  Self newInstance(T value, ValitySchema<T> schema, ValityIssue? issue);

  Self copyWith({required T value}) {
    final issue = schema.validate(value);
    return newInstance(value, schema, issue);
  }

  @override
  List<Object?> get props => [value, schema, issue];
}

class ValityField<T> extends BaseValityField<T, ValityField<T>> {
  ValityField({required super.value, required super.schema, super.issue});

  @override
  ValityField<T> newInstance(
      T value, ValitySchema<T> schema, ValityIssue? issue) {
    return ValityField<T>(value: value, schema: schema, issue: issue);
  }
}
