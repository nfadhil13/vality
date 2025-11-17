// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get notNull => 'This field is required';

  @override
  String get notEmpty => 'This field cannot be empty';

  @override
  String minLength(int min) {
    return 'Must be at least $min characters';
  }

  @override
  String maxLength(int max) {
    return 'Must be at most $max characters';
  }

  @override
  String get email => 'Please enter a valid email address';

  @override
  String get url => 'Please enter a valid URL';

  @override
  String contains(String substring) {
    return 'Must contain \"$substring\"';
  }

  @override
  String containsNofString(int minCount, String substring) {
    return 'Must contain at least $minCount occurrence(s) of \"$substring\"';
  }

  @override
  String containsNofRegex(int minCount) {
    return 'Must contain at least $minCount match(es)';
  }

  @override
  String get startsWith => 'Must start with the specified prefix';

  @override
  String get endsWith => 'Must end with the specified suffix';

  @override
  String get matches => 'Must match the specified pattern';

  @override
  String get alphanumeric => 'Only letters and numbers are allowed';

  @override
  String get numeric => 'Only numbers are allowed';

  @override
  String containsUpperCase(int minCount) {
    return 'Must contain at least $minCount uppercase letter(s)';
  }

  @override
  String containsLowerCase(int minCount) {
    return 'Must contain at least $minCount lowercase letter(s)';
  }

  @override
  String containsNumbers(int minCount) {
    return 'Must contain at least $minCount number(s)';
  }

  @override
  String containsSpecialChar(int minCount) {
    return 'Must contain at least $minCount special character(s)';
  }

  @override
  String minValue(num min) {
    return 'Must be at least $min';
  }

  @override
  String maxValue(num max) {
    return 'Must be at most $max';
  }

  @override
  String range(num min, num max) {
    return 'Must be between $min and $max';
  }

  @override
  String get positive => 'Must be a positive number';

  @override
  String get negative => 'Must be a negative number';

  @override
  String get integer => 'Must be an integer';

  @override
  String get double => 'Must be a decimal number';

  @override
  String get containsItem => 'Must contain the specified item';

  @override
  String get uniqueItems => 'All items must be unique';

  @override
  String get containsKey => 'Must contain the specified key';

  @override
  String get containsValue => 'Must contain the specified value';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get validationError => 'Validation error';
}
