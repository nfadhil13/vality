# Dummy Readyme

<!-- # Vality

A powerful, type-safe validation library for Dart and Flutter. Vality provides a flexible and composable way to validate data with built-in support for strings, numbers, collections, and custom validation rules.

## Features

- 🎯 **Type-Safe**: Full type safety with Dart generics
- 🔧 **Composable**: Chain validation rules together easily
- 🌍 **i18n Ready**: Built-in translation support for error messages
- 🚀 **Performant**: Stops validation at the first failing rule
- 🎨 **Flexible**: Create custom validation rules with ease

## Installation

Add `vality` to your `pubspec.yaml`:

```yaml
dependencies:
  vality: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Getting Started

### Basic Usage

```dart
import 'package:vality/vality.dart';

// Create a validation schema
final schema = ValitySchema<String?>([
  notNull(),
  notEmpty(),
  minLengthString(3),
  maxLengthString(20),
]);

// Validate a value
final issue = schema.validate('test');
if (issue != null) {
  print('Validation failed: ${issue.code}');
} else {
  print('Validation passed!');
}
```

### Using ValityField

`ValityField` provides a convenient way to manage field state and validation:

```dart
final field = ValityField<String?>(
  value: 'test',
  schema: ValitySchema<String?>([
    notNull(),
    notEmpty(),
    minLengthString(3),
  ]),
);

// Check if valid
if (field.isValid) {
  print('Field is valid');
} else {
  print('Error: ${field.issue?.code}');
}

// Update value and revalidate
final updatedField = field.copyWith(value: 'new value');
```

## Core Concepts

### ValityIssue

Represents a validation error with an error code and optional parameters.

```dart
final issue = ValityIssue(
  code: ValityRuleBase.minLength,
  params: {
    ValityParams.min: 8,
    ValityParams.length: 5,
  },
);
```

### ValityRule

A rule is a function that validates a value and returns a `ValityIssue` if validation fails, or `null` if it passes.

```dart
// Built-in rules
final rule = notNull();

// Custom rule
ValityRule<String?> customRule = (value) {
  if (value == null || value.length < 5) {
    return ValityIssue(code: 'customError');
  }
  return null;
};
```

### ValitySchema

A schema defines a collection of validation rules that are applied in order. Validation stops at the first failing rule.

```dart
final schema = ValitySchema<String?>([
  notNull(),
  notEmpty(),
  minLengthString(8),
]);

// Or build incrementally
final schema = ValitySchema<String?>([notNull()])
  .add(notEmpty())
  .add(minLengthString(8));
```

### ValityField

A field combines a value with its validation schema, providing a convenient way to manage form field state.

```dart
class UsernameField extends ValityField<String?> {
  UsernameField({required super.value, super.issue})
      : super(schema: ValitySchema<String?>([
          notNull(),
          notEmpty(),
          minLengthString(3),
          maxLengthString(20),
        ]));

  @override
  UsernameField copyWith({required String? value}) {
    final issue = schema.validate(value);
    return UsernameField(value: value, issue: issue);
  }
}
```

## Available Validators

### Common Validators

- `notNull<T>()` - Validates that a value is not null
- `notEmpty()` - Validates that a String is not empty

### String Validators

#### Length

- `minLengthString(int min)` - Minimum string length
- `maxLengthString(int max)` - Maximum string length

#### Format

- `email()` - Valid email address
- `url()` - Valid URL
- `alphanumeric()` - Only letters and numbers
- `numeric()` - Only numeric characters

#### Content

- `containsString(String substring)` - Contains substring
- `containsNofString(String substring, int minCount)` - Contains at least N occurrences
- `containsNofRegex(RegExp pattern, int minCount)` - Contains at least N regex matches
- `startsWithString(String prefix)` - Starts with prefix
- `endsWithString(String suffix)` - Ends with suffix
- `matchesPattern(RegExp pattern)` - Matches regex pattern

#### Character Requirements

- `containsUpperCase([int minCount = 1])` - Contains uppercase letters
- `containsLowerCase([int minCount = 1])` - Contains lowercase letters
- `containsNumbers([int minCount = 1])` - Contains numbers
- `containsSpecialChar([int minCount = 1])` - Contains special characters

### Number Validators

- `minValue(num min)` - Minimum value
- `maxValue(num max)` - Maximum value
- `range(num min, num max)` - Value within range
- `positive()` - Must be positive
- `negative()` - Must be negative
- `integer()` - Must be an integer

### List Validators

- `minLengthList<T>(int min)` - Minimum list length
- `maxLengthList<T>(int max)` - Maximum list length
- `containsItem<T>(T item)` - Contains specific item
- `uniqueItems<T>()` - All items are unique

### Set Validators

- `minLengthSet<T>(int min)` - Minimum set length
- `maxLengthSet<T>(int max)` - Maximum set length
- `containsItemSet<T>(T item)` - Contains specific item

### Map Validators

- `minLengthMap<K, V>(int min)` - Minimum map length
- `maxLengthMap<K, V>(int max)` - Maximum map length
- `containsKey<K, V>(K key)` - Contains specific key
- `containsValue<K, V>(V val)` - Contains specific value

## Usage Examples

### Form Validation

```dart
// Define schemas
final usernameSchema = ValitySchema<String?>([
  notNull(),
  notEmpty(),
  minLengthString(3),
  maxLengthString(20),
  alphanumeric(),
]);

final emailSchema = ValitySchema<String?>([
  notNull(),
  notEmpty(),
  email(),
]);

final passwordSchema = ValitySchema<String?>([
  notNull(),
  notEmpty(),
  minLengthString(8),
  maxLengthString(50),
  containsUpperCase(1),
  containsLowerCase(1),
  containsNumbers(2),
  containsSpecialChar(1),
]);

// Use in form
final usernameField = ValityField<String?>(
  value: '',
  schema: usernameSchema,
);

// Update and validate
final updatedField = usernameField.copyWith(value: 'user123');
if (updatedField.isValid) {
  // Proceed with valid username
}
```

### Number Validation

```dart
final ageSchema = ValitySchema<int?>([
  notNull(),
  minValue(18),
  maxValue(120),
]);

final priceSchema = ValitySchema<double?>([
  notNull(),
  positive(),
  maxValue(1000.0),
]);
```

### Collection Validation

```dart
// List validation
final tagsSchema = ValitySchema<List<String>?>([
  notNull(),
  minLengthList(1),
  maxLengthList(10),
  uniqueItems(),
]);

// Map validation
final configSchema = ValitySchema<Map<String, dynamic>?>([
  notNull(),
  containsKey('apiKey'),
  containsKey('apiSecret'),
]);
```

### Custom Validation Rules

```dart
// Custom rule for password confirmation
ValityRule<String?> passwordMatch(String? password) {
  return (value) {
    if (value == null || value != password) {
      return ValityIssue(code: 'passwordMismatch');
    }
    return null;
  };
}

// Use in schema
final rePasswordSchema = ValitySchema<String?>([
  notNull(),
  notEmpty(),
  passwordMatch(originalPassword),
]);
```

## Internationalization

Vality provides built-in support for translating validation errors.

### Using Default Translations

```dart
final issue = schema.validate('abc');
if (issue != null) {
  final message = ValityTranslationsHelper.translateDefault(issue);
  print(message); // "Must be at least 8 characters"
}
```

### Custom Translations

```dart
class IndonesianTranslations extends DefaultValityTranslations {
  @override
  String notNull() => 'Field ini wajib diisi';

  @override
  String minLength(int min) => 'Minimal $min karakter';

  @override
  String email() => 'Masukkan alamat email yang valid';

  @override
  String? translateCustom(ValityIssue issue) {
    switch (issue.code) {
      case 'passwordMismatch':
        return 'Password tidak cocok';
      default:
        return null;
    }
  }
}

// Use custom translations
final translations = IndonesianTranslations();
final message = ValityTranslationsHelper.translate(issue, translations);
```

### Available Translation Methods

The `ValityTranslations` abstract class provides methods for all standard error codes:

- `notNull()`, `notEmpty()`
- `minLength(int min)`, `maxLength(int max)`
- `email()`, `url()`
- `contains(String substring)`, `containsNofString(int minCount, String substring)`
- `containsUpperCase(int minCount)`, `containsLowerCase(int minCount)`
- `containsNumbers(int minCount)`, `containsSpecialChar(int minCount)`
- `minValue(num min)`, `maxValue(num max)`, `range(num min, num max)`
- `positive()`, `negative()`, `integer()`, `doubleValue()`
- `containsItem()`, `uniqueItems()`
- `containsKey()`, `containsValue()`
- `translateCustom(ValityIssue issue)` - For custom error codes
- `validationError()` - Default error message

## Error Codes and Parameters

### Error Code Constants

All error codes are available as constants in `ValityRuleBase`:

```dart
ValityRuleBase.notNull
ValityRuleBase.notEmpty
ValityRuleBase.minLength
ValityRuleBase.maxLength
ValityRuleBase.email
ValityRuleBase.url
// ... and more
```

### Parameter Constants

Use `ValityParams` for type-safe parameter access:

```dart
ValityParams.min        // Minimum value/length
ValityParams.max        // Maximum value/length
ValityParams.length     // Actual length
ValityParams.minCount   // Minimum count required
ValityParams.value      // Actual value
ValityParams.substring  // Substring being searched
ValityParams.item       // Item in collection
```

### Accessing Parameters

```dart
final issue = schema.validate(value);
if (issue?.code == ValityRuleBase.minLength) {
  final min = issue?.params?[ValityParams.min] as int?;
  final length = issue?.params?[ValityParams.length] as int?;
  print('Required: $min, Actual: $length');
}
```

## Advanced Usage

### Complete Form Example

See `example/register_form_example.dart` for a complete example of a registration form with multiple fields and validation.

### Flutter Integration

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late ValityField<String?> emailField;
  late ValityField<String?> passwordField;

  @override
  void initState() {
    super.initState();
    emailField = ValityField<String?>(
      value: '',
      schema: ValitySchema<String?>([
        notNull(),
        notEmpty(),
        email(),
      ]),
    );
    passwordField = ValityField<String?>(
      value: '',
      schema: ValitySchema<String?>([
        notNull(),
        notEmpty(),
        minLengthString(8),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              emailField = emailField.copyWith(value: value);
            });
          },
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: emailField.issue != null
                ? ValityTranslationsHelper.translateDefault(emailField.issue!)
                : null,
          ),
        ),
        // ... password field
      ],
    );
  }
}
```

## API Reference

### ValitySchema<T>

A collection of validation rules.

**Methods:**

- `ValitySchema([List<ValityRule<T>> rules = const []])` - Constructor
- `add(ValityRule<T> rule)` - Add a rule and return a new schema
- `validate(T value)` - Validate a value, returns `ValityIssue?`

### ValityField<T>

A field with value and validation schema.

**Properties:**

- `value` - The field value
- `schema` - The validation schema
- `issue` - The validation issue (null if valid)
- `isValid` - Whether the field is valid

**Methods:**

- `copyWith({required T value})` - Create a copy with new value and revalidate

### ValityRule<T>

A function type: `ValityIssue? Function(T value)`

### ValityIssue

Represents a validation error.

**Properties:**

- `code` - Error code string
- `params` - Optional parameters map

### ValityTranslationsHelper

Helper for translating validation issues.

**Methods:**

- `translate(ValityIssue issue, ValityTranslations translations)` - Translate with custom translations
- `translateDefault(ValityIssue issue)` - Translate with default English translations

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

## Additional Information

For more examples, see the `example/` directory in the repository. -->
