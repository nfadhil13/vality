import 'package:test/test.dart';
import 'package:vality/vality.dart';

void main() {
  group('ValityIssue equality test', () {
    test('ValityIssue is the same object should return equal', () {
      final issue = ValityIssue(code: ValityRuleBase.notNull);
      expect(issue == issue, isTrue);
    });

    test('ValityIssue is Equal by value should return equal', () {
      final issue1 = ValityIssue(code: ValityRuleBase.notNull);
      final issue2 = ValityIssue(code: ValityRuleBase.notNull);
      expect(issue1 == issue2, isTrue);
    });

    test('ValityIssue is not equal by value should return notEqual', () {
      final issue1 = ValityIssue(code: ValityRuleBase.notNull);
      final issue2 = ValityIssue(code: ValityRuleBase.notEmpty);
      expect(issue1 == issue2, isFalse);
    });
  });
}
