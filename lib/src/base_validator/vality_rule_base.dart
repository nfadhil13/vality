import 'package:vality/src/vality_issue.dart';
import 'package:vality/src/vality_rule.dart';

class ValityRuleBase {
  static String notNull = 'notNull';
  static String notEmpty = 'notEmpty';
  static String minLength = 'minLength';
  static String maxLength = 'maxLength';
  static String email = 'email';
  static String url = 'url';

  static setRuleCodes(
      {String? notNull,
      String? notEmpty,
      String? minLength,
      String? maxLength,
      String? email,
      String? url}) {
    ValityRuleBase.notNull = notNull ?? ValityRuleBase.notNull;
    ValityRuleBase.notEmpty = notEmpty ?? ValityRuleBase.notEmpty;
    ValityRuleBase.minLength = minLength ?? ValityRuleBase.minLength;
    ValityRuleBase.maxLength = maxLength ?? ValityRuleBase.maxLength;
    ValityRuleBase.email = email ?? ValityRuleBase.email;
    ValityRuleBase.url = url ?? ValityRuleBase.url;
  }
}

ValityRule<T> notNull<T>() =>
    (value) => value == null ? ValityIssue(code: ValityRuleBase.notNull) : null;

ValityRule<T> notEmpty<T>() => (value) => value is String && value.isEmpty
    ? ValityIssue(code: ValityRuleBase.notEmpty)
    : null;

ValityRule<T> minLength<T>(int minLength) => (value) =>
    value == null ? ValityIssue(code: ValityRuleBase.minLength) : null;

ValityRule<T> maxLength<T>(int maxLength) => (value) =>
    value == null ? ValityIssue(code: ValityRuleBase.maxLength) : null;

ValityRule<String?> email() =>
    (value) => value == null ? ValityIssue(code: ValityRuleBase.email) : null;

ValityRule<String?> url() =>
    (value) => value == null ? ValityIssue(code: ValityRuleBase.url) : null;
