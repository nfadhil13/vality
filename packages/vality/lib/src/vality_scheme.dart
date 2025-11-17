import 'package:equatable/equatable.dart';
import 'package:vality/src/vality_issue.dart';
import 'package:vality/src/vality_rule.dart';

/// A schema that defines validation rules for a value
///
/// Rules are validated in order, and validation stops at the first rule that fails.
///
/// **Example:**
/// ```dart
/// // Create schema with rules
/// final schema = ValitySchema<String?>([
///   notNull(),
///   notEmpty(),
///   minLengthString(3),
///   maxLengthString(20),
/// ]);
///
/// // Validate a value
/// final issue = schema.validate('test');
/// if (issue != null) {
///   print('Validation failed: ${issue.code}');
/// }
///
/// // Or use with ValityField
/// final field = ValityField<String?>(
///   value: 'test',
///   schema: schema,
/// );
/// ```
class ValitySchema<T> extends Equatable {
  /// The list of validation rules
  final List<ValityRule<T>> rules;

  /// Creates a ValitySchema with the given rules
  ///
  /// **Parameters:**
  /// - `rules` (List<ValityRule<T>>): The validation rules to apply
  ///
  /// **Example:**
  /// ```dart
  /// // Empty schema
  /// final emptySchema = ValitySchema<String?>();
  ///
  /// // Schema with rules
  /// final schema = ValitySchema<String?>([
  ///   notNull(),
  ///   notEmpty(),
  ///   minLengthString(8),
  /// ]);
  /// ```
  const ValitySchema([this.rules = const []]);

  /// Adds a rule to the schema and returns a new schema
  ///
  /// **Parameters:**
  /// - `rule` (ValityRule<T>): The rule to add
  ///
  /// **Returns:** A new ValitySchema with the added rule
  ///
  /// **Example:**
  /// ```dart
  /// final schema = ValitySchema<String?>([notNull()])
  ///   .add(notEmpty())
  ///   .add(minLengthString(3))
  ///   .add(maxLengthString(20));
  /// ```
  ValitySchema<T> add(ValityRule<T> rule) {
    return ValitySchema<T>([...rules, rule]);
  }

  /// Validates a value against all rules in the schema
  ///
  /// **Parameters:**
  /// - `value` (T): The value to validate
  ///
  /// **Returns:** `ValityIssue?` - The first validation issue found, or `null` if valid
  ///
  /// **Example:**
  /// ```dart
  /// final schema = ValitySchema<String?>([
  ///   notNull(),
  ///   minLengthString(5),
  /// ]);
  ///
  /// final issue = schema.validate('abc');
  /// if (issue != null) {
  ///   print('Validation failed: ${issue.code}');
  ///   if (issue.params != null) {
  ///     print('Params: ${issue.params}');
  ///   }
  /// }
  /// ```
  ValityIssue? validate(T value) {
    return ValityRuleBuilder.validate<T>(rules, value);
  }

  @override
  List<Object?> get props => [rules];
}
