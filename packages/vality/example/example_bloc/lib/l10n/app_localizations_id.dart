// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get notNull => 'Field ini wajib diisi';

  @override
  String get notEmptys => 'Field i ni tidak boleh kosong';

  @override
  String minLength(int min) {
    return 'Minimal $min karakter';
  }

  @override
  String maxLength(int max) {
    return 'Maksimal $max karakter';
  }

  @override
  String get email => 'Masukkan alamat email yang valid';

  @override
  String get url => 'Masukkan URL yang valid';

  @override
  String contains(String substring) {
    return 'Harus mengandung \"$substring\"';
  }

  @override
  String containsNofString(int minCount, String substring) {
    return 'Harus mengandung minimal $minCount kemunculan \"$substring\"';
  }

  @override
  String containsNofRegex(int minCount) {
    return 'Harus mengandung minimal $minCount kecocokan';
  }

  @override
  String get startsWith => 'Harus diawali dengan awalan yang ditentukan';

  @override
  String get endsWith => 'Harus diakhiri dengan akhiran yang ditentukan';

  @override
  String get matches => 'Harus sesuai dengan pola yang ditentukan';

  @override
  String get alphanumeric => 'Hanya huruf dan angka yang diperbolehkan';

  @override
  String get numeric => 'Hanya angka yang diperbolehkan';

  @override
  String containsUpperCase(int minCount) {
    return 'Minimal $minCount huruf besar';
  }

  @override
  String containsLowerCase(int minCount) {
    return 'Minimal $minCount huruf kecil';
  }

  @override
  String containsNumbers(int minCount) {
    return 'Minimal $minCount angka';
  }

  @override
  String containsSpecialChar(int minCount) {
    return 'Minimal $minCount karakter khusus';
  }

  @override
  String minValue(num min) {
    return 'Minimal $min';
  }

  @override
  String maxValue(num max) {
    return 'Maksimal $max';
  }

  @override
  String range(num min, num max) {
    return 'Harus antara $min dan $max';
  }

  @override
  String get positive => 'Harus bilangan positif';

  @override
  String get negative => 'Harus bilangan negatif';

  @override
  String get integer => 'Harus bilangan bulat';

  @override
  String get double => 'Harus bilangan desimal';

  @override
  String get containsItem => 'Harus mengandung item yang ditentukan';

  @override
  String get uniqueItems => 'Semua item harus unik';

  @override
  String get containsKey => 'Harus mengandung kunci yang ditentukan';

  @override
  String get containsValue => 'Harus mengandung nilai yang ditentukan';

  @override
  String get passwordMismatch => 'Password tidak cocok';

  @override
  String get validationError => 'Kesalahan validasi';
}
