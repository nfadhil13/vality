import 'package:test/test.dart';
import 'package:vality/vality.dart';

void main() {
  group('minValue', () {
    test('should return issue when value is null', () {
      final rule = minValue(5);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minValue));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.value], isNull);
    });

    test('should return issue when value is less than min', () {
      final rule = minValue(5);
      final issue = rule(3);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minValue));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.value], equals(3));
    });

    test('should return null when value equals min', () {
      final rule = minValue(5);
      final issue = rule(5);

      expect(issue, isNull);
    });

    test('should return null when value is greater than min', () {
      final rule = minValue(5);
      final issue = rule(10);

      expect(issue, isNull);
    });

    test('should work with double values', () {
      final rule = minValue(5.5);
      final issue = rule(3.2);

      expect(issue, isNotNull);
      expect(issue?.params?[ValityParams.min], equals(5.5));
      expect(issue?.params?[ValityParams.value], equals(3.2));
    });
  });

  group('maxValue', () {
    test('should return issue when value is null', () {
      final rule = maxValue(10);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxValue));
      expect(issue?.params?[ValityParams.max], equals(10));
      expect(issue?.params?[ValityParams.value], isNull);
    });

    test('should return issue when value is greater than max', () {
      final rule = maxValue(10);
      final issue = rule(15);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxValue));
      expect(issue?.params?[ValityParams.max], equals(10));
      expect(issue?.params?[ValityParams.value], equals(15));
    });

    test('should return null when value equals max', () {
      final rule = maxValue(10);
      final issue = rule(10);

      expect(issue, isNull);
    });

    test('should return null when value is less than max', () {
      final rule = maxValue(10);
      final issue = rule(5);

      expect(issue, isNull);
    });

    test('should work with double values', () {
      final rule = maxValue(10.5);
      final issue = rule(15.2);

      expect(issue, isNotNull);
      expect(issue?.params?[ValityParams.max], equals(10.5));
      expect(issue?.params?[ValityParams.value], equals(15.2));
    });
  });

  group('range', () {
    test('should return issue when value is null', () {
      final rule = range(5, 10);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.range));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.max], equals(10));
      expect(issue?.params?[ValityParams.value], equals(0));
    });

    test('should return issue when value is less than min', () {
      final rule = range(5, 10);
      final issue = rule(3);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.range));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.max], equals(10));
      expect(issue?.params?[ValityParams.value], equals(3));
    });

    test('should return issue when value is greater than max', () {
      final rule = range(5, 10);
      final issue = rule(15);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.range));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.max], equals(10));
      expect(issue?.params?[ValityParams.value], equals(15));
    });

    test('should return null when value equals min', () {
      final rule = range(5, 10);
      final issue = rule(5);

      expect(issue, isNull);
    });

    test('should return null when value equals max', () {
      final rule = range(5, 10);
      final issue = rule(10);

      expect(issue, isNull);
    });

    test('should return null when value is within range', () {
      final rule = range(5, 10);
      final issue = rule(7);

      expect(issue, isNull);
    });
  });

  group('positive', () {
    final rule = positive();

    test('should return issue when value is null', () {
      final issue = rule(null);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.positive));
    });

    test('should return issue when value is zero', () {
      final issue = rule(0);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.positive));
    });

    test('should return issue when value is negative', () {
      final issue = rule(-5);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.positive));
    });

    test('should return null when value is positive', () {
      final issue = rule(5);
      expect(issue, isNull);
    });
  });

  group('negative', () {
    final rule = negative();

    test('should return issue when value is null', () {
      final issue = rule(null);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.negative));
    });

    test('should return issue when value is zero', () {
      final issue = rule(0);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.negative));
    });

    test('should return issue when value is positive', () {
      final issue = rule(5);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.negative));
    });

    test('should return null when value is negative', () {
      final issue = rule(-5);
      expect(issue, isNull);
    });
  });

  group('integer', () {
    final rule = integer();

    test('should return issue when value is null', () {
      final issue = rule(null);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.integer));
    });

    test('should return issue when value is double', () {
      final issue = rule(5.5);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.integer));
    });

    test('should return null when value is integer', () {
      final issue = rule(5);
      expect(issue, isNull);
    });

    test('should return null when value is zero', () {
      final issue = rule(0);
      expect(issue, isNull);
    });
  });
}

