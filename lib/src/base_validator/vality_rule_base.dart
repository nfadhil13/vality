library vality_rule_base;

import 'package:vality/src/vality_issue.dart';
import 'package:vality/src/vality_rule.dart';
import 'package:vality/src/vality_regex.dart';
import 'package:vality/src/vality_params.dart';

part 'vality_rule_common.dart';
part 'vality_rule_string.dart';
part 'vality_rule_list.dart';
part 'vality_rule_map.dart';
part 'vality_rule_set.dart';
part 'vality_rule_number.dart';

/// Constants for validation error codes
///
/// These string constants are derived from [ValityErrorCode] enum for
/// backward compatibility. Users should use these constants when creating
/// custom validation rules or checking error codes.
///
/// **Example:**
/// ```dart
/// final issue = ValityIssue(code: ValityRuleBase.notNull);
/// if (issue.code == ValityRuleBase.notNull) {
///   // Handle not null error
/// }
/// ```
class ValityRuleBase {
  ValityRuleBase._(); // coverage:ignore-line

  // Common
  static const String notNull = 'notNull';
  static const String notEmpty = 'notEmpty';
  static const String minLength = 'minLength';
  static const String maxLength = 'maxLength';

  // String
  static const String email = 'email';
  static const String url = 'url';
  static const String contains = 'contains';
  static const String containsNofString = 'containsNofString';
  static const String containsNofRegex = 'containsNofRegex';
  static const String containsUpperCase = 'containsUpperCase';
  static const String containsLowerCase = 'containsLowerCase';
  static const String containsNumbers = 'containsNumbers';
  static const String containsSpecialChar = 'containsSpecialChar';
  static const String startsWith = 'startsWith';
  static const String endsWith = 'endsWith';
  static const String matches = 'matches';
  static const String alphanumeric = 'alphanumeric';
  static const String numeric = 'numeric';

  // Number
  static const String minValue = 'minValue';
  static const String maxValue = 'maxValue';
  static const String range = 'range';
  static const String positive = 'positive';
  static const String negative = 'negative';
  static const String integer = 'integer';
  static const String double = 'double';

  // List
  static const String containsItem = 'containsItem';
  static const String uniqueItems = 'uniqueItems';

  // Map
  static const String containsKey = 'containsKey';
  static const String containsValue = 'containsValue';
}
