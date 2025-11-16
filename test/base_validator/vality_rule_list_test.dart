import 'package:test/test.dart';
import 'package:vality/vality.dart';

void main() {
  group('minLengthList', () {
    test('should return issue when value is null', () {
      final rule = minLengthList<int>(5);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minLength));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.length], equals(0));
    });

    test('should return issue when length is less than min', () {
      final rule = minLengthList<int>(5);
      final example = [1, 2, 3];
      final issue = rule(example);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minLength));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.length], equals(example.length));
    });

    test('should return null when length is equal to min', () {
      final rule = minLengthList<int>(5);
      final issue = rule([1, 2, 3, 4, 5]);

      expect(issue, isNull);
    });

    test('should return null when length is greater than min', () {
      final rule = minLengthList<int>(5);
      final issue = rule([1, 2, 3, 4, 5, 6]);

      expect(issue, isNull);
    });
  });

  group('maxLengthList', () {
    test('should return issue when value is null', () {
      final rule = maxLengthList<int>(10);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxLength));
      expect(issue?.params?[ValityParams.max], equals(10));
      expect(issue?.params?[ValityParams.length], equals(0));
    });

    test('should return issue when length is greater than max', () {
      final rule = maxLengthList<int>(5);
      final example = [1, 2, 3, 4, 5, 6];
      final issue = rule(example);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxLength));
      expect(issue?.params?[ValityParams.max], equals(5));
      expect(issue?.params?[ValityParams.length], equals(example.length));
    });

    test('should return null when length is equal to max', () {
      final rule = maxLengthList<int>(5);
      final issue = rule([1, 2, 3, 4, 5]);

      expect(issue, isNull);
    });

    test('should return null when length is less than max', () {
      final rule = maxLengthList<int>(5);
      final issue = rule([1, 2, 3]);

      expect(issue, isNull);
    });
  });

  group('containsItem', () {
    test('should return issue when value is null', () {
      final rule = containsItem<int>(5);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsItem));
      expect(issue?.params?[ValityParams.item], equals(5));
    });

    test('should return issue when list does not contain item', () {
      final rule = containsItem<int>(5);
      final issue = rule([1, 2, 3]);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsItem));
      expect(issue?.params?[ValityParams.item], equals(5));
    });

    test('should return null when list contains item', () {
      final rule = containsItem<int>(5);
      final issue = rule([1, 2, 3, 4, 5]);

      expect(issue, isNull);
    });

    test('should work with string items', () {
      final rule = containsItem<String>('test');
      final issue = rule(['hello', 'world']);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsItem));
      expect(issue?.params?[ValityParams.item], equals('test'));
    });
  });

  group('uniqueItems', () {
    final rule = uniqueItems<int>();

    test('should return issue when value is null', () {
      final issue = rule(null);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.uniqueItems));
    });

    test('should return issue when list contains duplicates', () {
      final issue = rule([1, 2, 3, 2, 4]);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.uniqueItems));
      expect(issue?.params?[ValityParams.length], equals(5));
    });

    test('should return null when all items are unique', () {
      final issue = rule([1, 2, 3, 4, 5]);
      expect(issue, isNull);
    });

    test('should return null when list is empty', () {
      final issue = rule([]);
      expect(issue, isNull);
    });

    test('should work with string items', () {
      final rule = uniqueItems<String>();
      final issue = rule(['a', 'b', 'a']);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.uniqueItems));
    });
  });
}
