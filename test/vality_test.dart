import 'package:test/test.dart';
import 'package:vality/vality.dart';

void main() {
  const notNullCode = 'NOT_NULL';

  const localizations = {
    notNullCode: 'Tidak boleh kosong',
  };

  group("Not Null Rule", () {
    setUp(() {
      ValityRuleBase.setRuleCodes(notNull: notNullCode);
    });

    final schema = ValitySchema<String?>([notNull()]);
    var field = ValityField<String?>(value: 'test', schema: schema);

    test("should return issue when value is null", () {
      field = field.copyWith(value: null);
      expect(field.issue, isNotNull);
      expect(field.isValid, isFalse);
      expect(field.issue?.code, equals(notNullCode));
      expect(
          localizations[field.issue?.code], equals(localizations[notNullCode]));
    });

    test("should return null when value is not null", () {
      field = field.copyWith(value: 'test');
      expect(field.isValid, isTrue);
      expect(field.issue, isNull);
    });
  });
}
