import 'package:test/test.dart';
import 'package:vality/vality.dart';

void main() {
  group("notNull", () {
    final rule = notNull<int?>();

    test("should return issue when value is null", () {
      final issue = rule(null);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.notNull));
    });

    test("should return null when value is not null", () {
      final issue = rule(1);
      expect(issue, isNull);
    });
  });

  group("minLength", () {
    test("should return issue when value is null", () {
      final rule = minLength<String?>(5, (value) => value?.length ?? 0);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minLength));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.length], equals(0));
    });

    test("should return issue when length is less than min", () {
      final rule = minLength<String>(5, (value) => value.length);
      final example = 'abc';
      final issue = rule(example);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minLength));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.length], equals(example.length));
    });

    test("should return null when length is equal to min", () {
      final rule = minLength<String>(5, (value) => value.length);
      final issue = rule('abcde');

      expect(issue, isNull);
    });

    test("should return null when length is greater than min", () {
      final rule = minLength<String>(5, (value) => value.length);
      final issue = rule('abcdef');

      expect(issue, isNull);
    });
  });

  group("maxLength", () {
    test("should return issue when value is null", () {
      final rule = maxLength<String?>(10, (value) => value?.length ?? 0);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxLength));
      expect(issue?.params?[ValityParams.max], equals(10));
      expect(issue?.params?[ValityParams.length], equals(0));
    });

    test("should return issue when length is greater than max", () {
      final rule = maxLength<String>(5, (value) => value.length);
      final example = 'abcdef';
      final issue = rule(example);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxLength));
      expect(issue?.params?[ValityParams.max], equals(5));
      expect(issue?.params?[ValityParams.length], equals(example.length));
    });

    test("should return null when length is equal to max", () {
      final rule = maxLength<String>(5, (value) => value.length);
      final example = 'abcde';
      final issue = rule(example);

      expect(issue, isNull);
    });

    test("should return null when length is less than max", () {
      final rule = maxLength<String>(5, (value) => value.length);
      final issue = rule('abc');

      expect(issue, isNull);
    });
  });
}
