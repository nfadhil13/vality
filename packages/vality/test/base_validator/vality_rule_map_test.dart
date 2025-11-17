import 'package:test/test.dart' hide containsValue;
import 'package:vality/vality.dart';

void main() {
  group('minLengthMap', () {
    test('should return issue when value is null', () {
      final rule = minLengthMap<String, int>(5);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minLength));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.length], equals(0));
    });

    test('should return issue when length is less than min', () {
      final rule = minLengthMap<String, int>(5);
      final example = {'a': 1, 'b': 2, 'c': 3};
      final issue = rule(example);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minLength));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.length], equals(example.length));
    });

    test('should return null when length is equal to min', () {
      final rule = minLengthMap<String, int>(5);
      final issue = rule({'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5});

      expect(issue, isNull);
    });

    test('should return null when length is greater than min', () {
      final rule = minLengthMap<String, int>(5);
      final issue = rule({'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5, 'f': 6});

      expect(issue, isNull);
    });
  });

  group('maxLengthMap', () {
    test('should return issue when value is null', () {
      final rule = maxLengthMap<String, int>(10);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxLength));
      expect(issue?.params?[ValityParams.max], equals(10));
      expect(issue?.params?[ValityParams.length], equals(0));
    });

    test('should return issue when length is greater than max', () {
      final rule = maxLengthMap<String, int>(5);
      final example = {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5, 'f': 6};
      final issue = rule(example);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxLength));
      expect(issue?.params?[ValityParams.max], equals(5));
      expect(issue?.params?[ValityParams.length], equals(example.length));
    });

    test('should return null when length is equal to max', () {
      final rule = maxLengthMap<String, int>(5);
      final issue = rule({'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5});

      expect(issue, isNull);
    });

    test('should return null when length is less than max', () {
      final rule = maxLengthMap<String, int>(5);
      final issue = rule({'a': 1, 'b': 2, 'c': 3});

      expect(issue, isNull);
    });
  });

  group('containsKey', () {
    test('should return issue when value is null', () {
      final rule = containsKey<String, int>('test');
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsKey));
    });

    test('should return issue when map does not contain key', () {
      final rule = containsKey<String, int>('test');
      final issue = rule({'a': 1, 'b': 2});

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsKey));
    });

    test('should return null when map contains key', () {
      final rule = containsKey<String, int>('test');
      final issue = rule({'a': 1, 'test': 2, 'b': 3});

      expect(issue, isNull);
    });
  });

  group('containsValue', () {
    test('should return issue when value is null', () {
      final rule = containsValue<String, int>(5);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsValue));
    });

    test('should return issue when map does not contain value', () {
      final rule = containsValue<String, int>(5);
      final issue = rule({'a': 1, 'b': 2});

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsValue));
    });

    test('should return null when map contains value', () {
      final rule = containsValue<String, int>(5);
      final issue = rule({'a': 1, 'b': 5, 'c': 3});

      expect(issue, isNull);
    });
  });
}
