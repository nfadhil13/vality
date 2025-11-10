import 'package:vality/src/vality_issue.dart';

/// {@template vality_rule}
/// A rule that can be used to validate a value
/// {@endtemplate}
typedef ValityRule<T> = ValityIssue? Function(T value);

class ValityRuleBuilder {
  static ValityIssue? validate<T>(List<ValityRule<T>> rules, T value) {
    for (final rule in rules) {
      final issue = rule(value);
      if (issue != null) return issue;
    }
    return null;
  }
}
