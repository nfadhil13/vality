import 'package:test/test.dart';
import 'package:vality/vality.dart';

void main() {
  group('minLengthSet', () {
    test('should return issue when value is null', () {
      final rule = minLengthSet<int>(5);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minLength));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.length], equals(0));
    });

    test('should return issue when length is less than min', () {
      final rule = minLengthSet<int>(5);
      final example = {1, 2, 3};
      final issue = rule(example);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minLength));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.length], equals(example.length));
    });

    test('should return null when length is equal to min', () {
      final rule = minLengthSet<int>(5);
      final issue = rule({1, 2, 3, 4, 5});

      expect(issue, isNull);
    });

    test('should return null when length is greater than min', () {
      final rule = minLengthSet<int>(5);
      final issue = rule({1, 2, 3, 4, 5, 6});

      expect(issue, isNull);
    });
  });

  group('maxLengthSet', () {
    test('should return issue when value is null', () {
      final rule = maxLengthSet<int>(10);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxLength));
      expect(issue?.params?[ValityParams.max], equals(10));
      expect(issue?.params?[ValityParams.length], equals(0));
    });

    test('should return issue when length is greater than max', () {
      final rule = maxLengthSet<int>(5);
      final example = {1, 2, 3, 4, 5, 6};
      final issue = rule(example);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxLength));
      expect(issue?.params?[ValityParams.max], equals(5));
      expect(issue?.params?[ValityParams.length], equals(example.length));
    });

    test('should return null when length is equal to max', () {
      final rule = maxLengthSet<int>(5);
      final issue = rule({1, 2, 3, 4, 5});

      expect(issue, isNull);
    });

    test('should return null when length is less than max', () {
      final rule = maxLengthSet<int>(5);
      final issue = rule({1, 2, 3});

      expect(issue, isNull);
    });
  });

  group('containsItemSet', () {
    test('should return issue when value is null', () {
      final rule = containsItemSet<int>(5);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsItem));
      expect(issue?.params?[ValityParams.item], equals(5));
    });

    test('should return issue when set does not contain item', () {
      final rule = containsItemSet<int>(5);
      final issue = rule({1, 2, 3});

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsItem));
      expect(issue?.params?[ValityParams.item], equals(5));
    });

    test('should return null when set contains item', () {
      final rule = containsItemSet<int>(5);
      final issue = rule({1, 2, 3, 4, 5});

      expect(issue, isNull);
    });

    test('should work with string items', () {
      final rule = containsItemSet<String>('test');
      final issue = rule({'hello', 'world'});

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsItem));
      expect(issue?.params?[ValityParams.item], equals('test'));
    });
  });
}

