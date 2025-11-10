import 'package:test/test.dart';
import 'package:vality/vality.dart';

class NameField extends BaseValityField<String?, NameField> {
  NameField({required super.value})
      : super(
            schema: ValitySchema(
                [notNull(), notEmpty(), minLength(3), maxLength(20)]));

  const NameField._({
    required super.value,
    required super.schema,
    required super.issue,
  });

  @override
  NameField newInstance(
    String? value,
    ValitySchema<String?> schema,
    ValityIssue? issue,
  ) =>
      NameField._(value: value, schema: schema, issue: issue);
}

void main() {
  group("NameField", () {
    var field = NameField(value: '');

    setUp(() {
      ValityRuleBase.setRuleCodes(notEmpty: 'notEmpty');
    });

    test("should return issue when value is empty", () {
      field = field.copyWith(value: '');
      expect(field.issue, isNotNull);
      expect(field.isValid, isFalse);
      expect(field.issue?.code, equals('notEmpty'));
    });

    test("should return null when value is not empty", () {
      field = field.copyWith(value: 'test');
      expect(field.issue, isNull);
      expect(field.isValid, isTrue);
    });
  });
}
