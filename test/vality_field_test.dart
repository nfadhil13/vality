import 'package:test/test.dart';
import 'package:vality/vality.dart';

void main() {
  group('ValityField equal test', () {
    test('ValityField is the same object should return equal', () {
      final field1 = ValityField(
          value: '',
          schema: ValitySchema<String?>().add(notNull()).add(notEmpty()));
      final field2 = field1;
      expect(field1 == field2, isTrue);
    });

    test('ValityField is Equal by value should return equal', () {
      final schema = ValitySchema<String?>().add(notNull()).add(notEmpty());
      ValityField buildField() => ValityField(value: '', schema: schema);
      final field1 = buildField();
      final field2 = buildField();
      expect(field1 == field2, isTrue);
    });

    test('ValityField is not equal by value should return notEqual', () {
      final field1 = ValityField(
          value: '',
          schema: ValitySchema<String?>().add(notNull()).add(notEmpty()));
      final field2 = ValityField(
          value: '',
          schema: ValitySchema<String?>()
              .add(notNull())
              .add(notEmpty())
              .add(minLengthString(1)));
      expect(field1 == field2, isFalse);
    });
  });
}
