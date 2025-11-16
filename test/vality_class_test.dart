import 'package:test/test.dart';
import 'package:vality/vality.dart';

final nameSchema = ValitySchema<String?>()
    .add(notNull())
    .add(notEmpty())
    .add(minLengthString(3))
    .add(maxLengthString(20));

class NameField extends ValityField<String?> {
  NameField({required super.value, super.issue})
      : super(
            schema: ValitySchema([
          notNull(),
          notEmpty(),
          minLengthString(3),
          maxLengthString(20),
        ]));

  @override
  NameField copyWith({required String? value}) {
    final issue = schema.validate(value);
    return NameField(value: value, issue: issue);
  }
}

void main() {
  group("NameField", () {
    var field = NameField(value: '');

    test("should return issue when value is empty", () {
      field = field.copyWith(value: '');
      expect(field.issue, isNotNull);
      expect(field.isValid, isFalse);
      expect(field.issue?.code, equals(ValityRuleBase.notEmpty));
    });

    test("should return null when value is not empty", () {
      field = field.copyWith(value: 'test');
      expect(field.issue, isNull);
      expect(field.isValid, isTrue);
    });
  });
}
