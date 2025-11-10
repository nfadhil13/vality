import 'package:equatable/equatable.dart';
import 'package:vality/src/vality_issue.dart';
import 'package:vality/src/vality_rule.dart';

class ValitySchema<T> extends Equatable {
  final List<ValityRule<T>> rules;

  const ValitySchema([this.rules = const []]);

  ValitySchema<T> add(ValityRule<T> rule) {
    return ValitySchema<T>([...rules, rule]);
  }

  ValityIssue? validate(T value) {
    return ValityRuleBuilder.validate<T>(rules, value);
  }

  @override
  List<Object?> get props => [rules];
}
