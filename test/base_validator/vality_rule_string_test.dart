import 'package:test/test.dart';
import 'package:vality/vality.dart' hide notNull;

void main() {
  group('notEmpty', () {
    final rule = notEmpty();

    test('should return issue when value is null', () {
      final issue = rule(null);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.notEmpty));
    });

    test('should return issue when value is empty', () {
      final issue = rule('');
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.notEmpty));
    });

    test('should return null when value is not empty', () {
      final issue = rule('test');
      expect(issue, isNull);
    });
  });

  group('minLengthString', () {
    test('should return issue when value is null', () {
      final rule = minLengthString(5);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minLength));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.length], equals(0));
    });

    test('should return issue when length is less than min', () {
      final rule = minLengthString(5);
      final example = 'abc';
      final issue = rule(example);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.minLength));
      expect(issue?.params?[ValityParams.min], equals(5));
      expect(issue?.params?[ValityParams.length], equals(example.length));
    });

    test('should return null when length is equal to min', () {
      final rule = minLengthString(5);
      final issue = rule('abcde');

      expect(issue, isNull);
    });

    test('should return null when length is greater than min', () {
      final rule = minLengthString(5);
      final issue = rule('abcdef');

      expect(issue, isNull);
    });
  });

  group('maxLengthString', () {
    test('should return issue when value is null', () {
      final rule = maxLengthString(10);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxLength));
      expect(issue?.params?[ValityParams.max], equals(10));
      expect(issue?.params?[ValityParams.length], equals(0));
    });

    test('should return issue when length is greater than max', () {
      final rule = maxLengthString(5);
      final example = 'abcdef';
      final issue = rule(example);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.maxLength));
      expect(issue?.params?[ValityParams.max], equals(5));
      expect(issue?.params?[ValityParams.length], equals(example.length));
    });

    test('should return null when length is equal to max', () {
      final rule = maxLengthString(5);
      final issue = rule('abcde');

      expect(issue, isNull);
    });

    test('should return null when length is less than max', () {
      final rule = maxLengthString(5);
      final issue = rule('abc');

      expect(issue, isNull);
    });
  });

  group('email', () {
    final rule = email();

    test('should return issue when value is null', () {
      final issue = rule(null);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.email));
    });

    test('should return issue when value is empty', () {
      final issue = rule('');
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.email));
    });

    test('should return issue when value is invalid email', () {
      final issue = rule('invalid-email');
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.email));
    });

    test('should return null when value is valid email', () {
      final issue = rule('test@example.com');
      expect(issue, isNull);
    });
  });

  group('url', () {
    final rule = url();

    test('should return issue when value is null', () {
      final issue = rule(null);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.url));
    });

    test('should return issue when value is empty', () {
      final issue = rule('');
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.url));
    });

    test('should return issue when value is invalid URL', () {
      final issue = rule('invalid-url');
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.url));
    });

    test('should return null when value is valid HTTP URL', () {
      final issue = rule('http://example.com');
      expect(issue, isNull);
    });

    test('should return null when value is valid HTTPS URL', () {
      final issue = rule('https://example.com');
      expect(issue, isNull);
    });
  });

  group('containsString', () {
    test('should return issue when value is null', () {
      final rule = containsString('test');
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.contains));
      expect(issue?.params?[ValityParams.substring], equals('test'));
    });

    test('should return issue when value does not contain substring', () {
      final rule = containsString('test');
      final issue = rule('hello');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.contains));
      expect(issue?.params?[ValityParams.substring], equals('test'));
    });

    test('should return null when value contains substring', () {
      final rule = containsString('test');
      final issue = rule('hello test world');

      expect(issue, isNull);
    });
  });

  group('containsNofString', () {
    test('should return issue when value is null', () {
      final rule = containsNofString('a', 2);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsNofString));
      expect(issue?.params?[ValityParams.substring], equals('a'));
      expect(issue?.params?[ValityParams.minCount], equals(2));
    });

    test('should return issue when value is empty', () {
      final rule = containsNofString('a', 2);
      final issue = rule('');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsNofString));
      expect(issue?.params?[ValityParams.minCount], equals(2));
    });

    test('should return issue when count is less than minCount', () {
      final rule = containsNofString('a', 2);
      final issue = rule('abc');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsNofString));
      expect(issue?.params?[ValityParams.minCount], equals(2));
    });

    test('should return null when count equals minCount', () {
      final rule = containsNofString('a', 2);
      final issue = rule('aab');

      expect(issue, isNull);
    });

    test('should return null when count is greater than minCount', () {
      final rule = containsNofString('a', 2);
      final issue = rule('aaab');

      expect(issue, isNull);
    });
  });

  group('containsNofRegex', () {
    test('should return issue when value is null', () {
      final rule = containsNofRegex(RegExp(r'[0-9]'), 2);
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsNofRegex));
      expect(issue?.params?[ValityParams.minCount], equals(2));
    });

    test('should return issue when value is empty', () {
      final rule = containsNofRegex(RegExp(r'[0-9]'), 2);
      final issue = rule('');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsNofRegex));
      expect(issue?.params?[ValityParams.minCount], equals(2));
    });

    test('should return issue when count is less than minCount', () {
      final rule = containsNofRegex(RegExp(r'[0-9]'), 2);
      final issue = rule('a1b');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsNofRegex));
      expect(issue?.params?[ValityParams.minCount], equals(2));
    });

    test('should return null when count equals minCount', () {
      final rule = containsNofRegex(RegExp(r'[0-9]'), 2);
      final issue = rule('a1b2c');

      expect(issue, isNull);
    });

    test('should return null when count is greater than minCount', () {
      final rule = containsNofRegex(RegExp(r'[0-9]'), 2);
      final issue = rule('a1b2c3d');

      expect(issue, isNull);
    });
  });

  group('containsUpperCase', () {
    test('should return issue when value is null', () {
      final rule = containsUpperCase();
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsUpperCase));
      expect(issue?.params?[ValityParams.minCount], equals(1));
    });

    test('should return issue when value is empty', () {
      final rule = containsUpperCase();
      final issue = rule('');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsUpperCase));
    });

    test('should return issue when no uppercase letters', () {
      final rule = containsUpperCase();
      final issue = rule('lowercase');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsUpperCase));
    });

    test('should return null when has uppercase letter', () {
      final rule = containsUpperCase();
      final issue = rule('Uppercase');

      expect(issue, isNull);
    });

    test('should return issue when count is less than minCount', () {
      final rule = containsUpperCase(2);
      final issue = rule('One');

      expect(issue, isNotNull);
      expect(issue?.params?[ValityParams.minCount], equals(2));
    });

    test('should return null when count equals minCount', () {
      final rule = containsUpperCase(2);
      final issue = rule('TwO');

      expect(issue, isNull);
    });
  });

  group('containsLowerCase', () {
    test('should return issue when value is null', () {
      final rule = containsLowerCase();
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsLowerCase));
      expect(issue?.params?[ValityParams.minCount], equals(1));
    });

    test('should return issue when value is empty', () {
      final rule = containsLowerCase();
      final issue = rule('');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsLowerCase));
    });

    test('should return issue when no lowercase letters', () {
      final rule = containsLowerCase();
      final issue = rule('UPPERCASE');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsLowerCase));
    });

    test('should return null when has lowercase letter', () {
      final rule = containsLowerCase();
      final issue = rule('Lowercase');

      expect(issue, isNull);
    });

    test('should return issue when count is less than minCount', () {
      final rule = containsLowerCase(2);
      final issue = rule('ONE');

      expect(issue, isNotNull);
      expect(issue?.params?[ValityParams.minCount], equals(2));
    });

    test('should return null when count equals minCount', () {
      final rule = containsLowerCase(2);
      final issue = rule('TwOo');

      expect(issue, isNull);
    });
  });

  group('containsNumbers', () {
    test('should return issue when value is null', () {
      final rule = containsNumbers();
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsNumbers));
      expect(issue?.params?[ValityParams.minCount], equals(1));
    });

    test('should return issue when value is empty', () {
      final rule = containsNumbers();
      final issue = rule('');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsNumbers));
    });

    test('should return issue when no numbers', () {
      final rule = containsNumbers();
      final issue = rule('letters');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsNumbers));
    });

    test('should return null when has number', () {
      final rule = containsNumbers();
      final issue = rule('letter1');

      expect(issue, isNull);
    });

    test('should return issue when count is less than minCount', () {
      final rule = containsNumbers(2);
      final issue = rule('letter1');

      expect(issue, isNotNull);
      expect(issue?.params?[ValityParams.minCount], equals(2));
    });

    test('should return null when count equals minCount', () {
      final rule = containsNumbers(2);
      final issue = rule('letter12');

      expect(issue, isNull);
    });
  });

  group('containsSpecialChar', () {
    test('should return issue when value is null', () {
      final rule = containsSpecialChar();
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsSpecialChar));
      expect(issue?.params?[ValityParams.minCount], equals(1));
    });

    test('should return issue when value is empty', () {
      final rule = containsSpecialChar();
      final issue = rule('');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsSpecialChar));
    });

    test('should return issue when no special characters', () {
      final rule = containsSpecialChar();
      final issue = rule('letters123');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.containsSpecialChar));
    });

    test('should return null when has special character', () {
      final rule = containsSpecialChar();
      final issue = rule('letter@123');

      expect(issue, isNull);
    });

    test('should return issue when count is less than minCount', () {
      final rule = containsSpecialChar(2);
      final issue = rule('letter@123');

      expect(issue, isNotNull);
      expect(issue?.params?[ValityParams.minCount], equals(2));
    });

    test('should return null when count equals minCount', () {
      final rule = containsSpecialChar(2);
      final issue = rule('letter@#123');

      expect(issue, isNull);
    });
  });

  group('startsWithString', () {
    test('should return issue when value is null', () {
      final rule = startsWithString('test');
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.startsWith));
    });

    test('should return issue when value does not start with prefix', () {
      final rule = startsWithString('test');
      final issue = rule('hello test');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.startsWith));
    });

    test('should return null when value starts with prefix', () {
      final rule = startsWithString('test');
      final issue = rule('test hello');

      expect(issue, isNull);
    });
  });

  group('endsWithString', () {
    test('should return issue when value is null', () {
      final rule = endsWithString('test');
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.endsWith));
    });

    test('should return issue when value does not end with suffix', () {
      final rule = endsWithString('test');
      final issue = rule('test hello');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.endsWith));
    });

    test('should return null when value ends with suffix', () {
      final rule = endsWithString('test');
      final issue = rule('hello test');

      expect(issue, isNull);
    });
  });

  group('matchesPattern', () {
    test('should return issue when value is null', () {
      final rule = matchesPattern(RegExp(r'^[a-z]+$'));
      final issue = rule(null);

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.matches));
    });

    test('should return issue when value does not match pattern', () {
      final rule = matchesPattern(RegExp(r'^[a-z]+$'));
      final issue = rule('Hello123');

      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.matches));
    });

    test('should return null when value matches pattern', () {
      final rule = matchesPattern(RegExp(r'^[a-z]+$'));
      final issue = rule('hello');

      expect(issue, isNull);
    });
  });

  group('alphanumeric', () {
    final rule = alphanumeric();
    test('should return issue when value is null', () {
      final issue = rule(null);
      expect(issue, isNotNull);
      expect(issue?.code, ValityRuleBase.alphanumeric);
    });

    test('should return issue when value is an empty string', () {
      final issue = rule('');
      expect(issue, isNotNull);
      expect(issue?.code, ValityRuleBase.alphanumeric);
    });

    test('should return issue when value is containing non alphanumeric char',
        () {
      final issue = rule('abCDe123!');
      expect(issue, isNotNull);
      expect(issue?.code, ValityRuleBase.alphanumeric);
    });

    test('should return null when value only contains alphanumeric', () {
      final issue = rule('abcDEC123');
      expect(issue, isNull);
    });
  });

  group('numeric', () {
    final rule = numeric();

    test('should return issue when value is null', () {
      final issue = rule(null);
      expect(issue, isNotNull);
      expect(issue?.code, ValityRuleBase.numeric);
    });

    test('should return issue when value is an empty string', () {
      final issue = rule('');
      expect(issue, isNotNull);
      expect(issue?.code, ValityRuleBase.numeric);
    });

    test('should return issue when value is containing non numeric char', () {
      final issue = rule('ABCabc123!');
      expect(issue, isNotNull);
      expect(issue?.code, ValityRuleBase.numeric);
    });

    test('should return null when value only contains numeric', () {
      final issue = rule('123456');
      expect(issue, isNull);
    });
  });
}
