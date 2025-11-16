import 'package:equatable/equatable.dart';
import 'package:vality/src/vality_issue.dart';
import 'package:vality/src/vality_scheme.dart';

/// A field that can be used to validate a value
///
/// **Example:**
/// ```dart
/// final schema = ValitySchema<String?>([
///   notNull(),
///   notEmpty(),
///   minLengthString(3),
/// ]);
///
/// var field = ValityField<String?>(
///   value: 'test',
///   schema: schema,
/// );
///
/// // Check validation
/// if (field.isValid) {
///   print('Field is valid');
/// } else {
///   print('Error: ${field.issue?.code}');
/// }
///
/// // Update value
/// field = field.copyWith(value: 'new value');
/// ```
class ValityField<T> extends Equatable {
  /// The value of the field
  final T value;

  /// The validation schema for this field
  final ValitySchema<T> schema;

  /// The validation issue, if any. Null if the field is valid.
  final ValityIssue? issue;

  /// Creates a ValityField with the given value and schema
  ///
  /// If `issue` is not provided, it will be calculated by validating
  /// the value against the schema.
  ///
  /// **Example:**
  /// ```dart
  /// final field = ValityField<String?>(
  ///   value: 'test',
  ///   schema: ValitySchema([notNull(), notEmpty()]),
  /// );
  /// ```
  const ValityField({required this.value, required this.schema, this.issue});

  /// Whether the field is valid (no validation issues)
  ///
  /// **Example:**
  /// ```dart
  /// if (field.isValid) {
  ///   // Proceed with valid value
  ///   submitForm(field.value);
  /// }
  /// ```
  bool get isValid => issue == null;

  /// Creates a copy of this field with a new value
  ///
  /// The new value will be validated against the schema,
  /// and a new issue will be calculated.
  ///
  /// **Example:**
  /// ```dart
  /// // Update field value and revalidate
  /// field = field.copyWith(value: 'new value');
  ///
  /// // Check if new value is valid
  /// if (field.isValid) {
  ///   print('New value is valid');
  /// }
  /// ```
  ValityField<T> copyWith({required T value}) {
    final issue = schema.validate(value);
    return ValityField<T>(value: value, schema: schema, issue: issue);
  }

  @override
  List<Object?> get props => [value, schema, issue];
}
