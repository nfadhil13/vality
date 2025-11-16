import 'package:test/test.dart';
import 'package:vality/vality.dart';

void main() {
  group('ValitySchema validate', () {
    final emailSchema = ValitySchema<String?>([
      notNull(),
      notEmpty(),
      email(),
    ]);

    test('Should return issue when value is null', () {
      final issue = emailSchema.validate(null);
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.notNull));
    });

    test('Should return issue when value is empty', () {
      final issue = emailSchema.validate('');
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.notEmpty));
    });

    test('Should return issue when value is not a valid email', () {
      final issue = emailSchema.validate('invalid-email');
      expect(issue, isNotNull);
      expect(issue?.code, equals(ValityRuleBase.email));
    });

    test('Should return null when value is a valid email', () {
      final issue = emailSchema.validate('mymail@example.com');
      expect(issue, isNull);
      expect(issue?.code, isNull);
    });
  });

  group('ValitySchema equality test', () {
    test('ValitySchema is the same object should return equal', () {
      final schema = ValitySchema<String?>([notNull(), notEmpty()]);
      expect(schema == schema, isTrue);
    });

    test('ValitySchema is Equal by value should return equal', () {
      final listOfRules = [notNull(), notEmpty()];
      final schema1 = ValitySchema<String?>(listOfRules);
      final schema2 = ValitySchema<String?>(listOfRules);
      expect(schema1 == schema2, isTrue);
    });

    test('ValitySchema is not equal by value should return notEqual', () {
      final schema1 = ValitySchema<String?>().add(notNull()).add(notEmpty());
      final schema2 = ValitySchema<String?>()
          .add(notNull())
          .add(notEmpty())
          .add(minLengthString(1));
      expect(schema1 == schema2, isFalse);
    });
  });
}
