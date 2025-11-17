import 'package:test/test.dart';
import 'package:vality/src/vality_issue.dart';
import 'package:vality/src/vality_rule.dart';
import 'package:vality/src/vality_translations.dart';

/// Test to ensure all ValityRuleBase constants have corresponding registry entries
///
/// This test helps maintainers catch missing registry entries when adding new error codes.
/// When adding a new error code:
/// 1. Add the constant to ValityRuleBase
/// 2. Add the method to ValityTranslations abstract class
/// 3. Implement it in DefaultValityTranslations
/// 4. Add an entry to ValityTranslationsHelper._errorCodeRegistry
/// 5. Add the constant to ValityTranslationsHelper.getAllStandardErrorCodes()
/// 6. Run this test to verify completeness
void main() {
  group('ValityTranslationsHelper Registry Completeness', () {
    test('all standard error codes should have registry entries', () {
      final allErrorCodes = ValityTranslationsHelper.getAllStandardErrorCodes();
      final registry = ValityTranslationsHelper.errorCodeRegistry;

      // Check that all error codes are in the registry
      for (final errorCode in allErrorCodes) {
        expect(
          registry.containsKey(errorCode),
          isTrue,
          reason: 'Error code "$errorCode" is missing from the registry. '
              'Add it to ValityTranslationsHelper._errorCodeRegistry',
        );
      }

      // Check that registry doesn't have extra entries (optional, but good to know)
      final registryKeys = registry.keys.toSet();
      final errorCodeSet = allErrorCodes.toSet();
      final extraKeys = registryKeys.difference(errorCodeSet);
      if (extraKeys.isNotEmpty) {
        fail(
          'Registry contains extra keys that are not in getAllStandardErrorCodes(): '
          '${extraKeys.join(", ")}. Either add them to getAllStandardErrorCodes() '
          'or remove them from the registry.',
        );
      }
    });

    test('registry should handle all standard error codes correctly', () {
      final translations = DefaultValityTranslations();
      final allErrorCodes = ValityTranslationsHelper.getAllStandardErrorCodes();

      // Test that each error code can be translated
      for (final errorCode in allErrorCodes) {
        final issue = ValityIssue(code: errorCode);
        final result = ValityTranslationsHelper.translate(issue, translations);

        expect(
          result,
          isNotEmpty,
          reason: 'Translation for "$errorCode" returned empty string',
        );
        expect(
          result,
          isNot(equals('Validation error')),
          reason:
              'Translation for "$errorCode" fell back to validationError(). '
              'Check that the registry entry is correct.',
        );
      }
    });
  });

  group('ValityTranslationsHelper translate', () {
    final list = ['apple', 'banana', 'cherry'];
    final translations = MyTranslations();

    test('Should return translation for notFound in List', () {
      final issue = notFoundInList(list)('orange');
      expect(issue, isNotNull);
      expect(issue?.code, equals(notFound));
      expect(issue?.params?['key'], equals('orange'));
      expect(ValityTranslationsHelper.translate(issue!, translations),
          equals('Not Found orange'));
    });

    test('Should return translation for notFound in List', () {
      final issue = notFoundInList(list)('banana');
      expect(issue, isNull);
    });

    test('Should return translation for unknown rule with default translations',
        () {
      final issue = unknownRule()('apple');
      expect(issue, isNotNull);
      expect(issue?.code, equals('unknown'));
      expect(ValityTranslationsHelper.translateDefault(issue!),
          equals(DefaultValityTranslations().validationError()));
    });

    test('Should return translation for unknown rule with custom translations',
        () {
      final issue = unknownRule()('apple');
      expect(issue, isNotNull);
      expect(issue?.code, equals('unknown'));
      expect(ValityTranslationsHelper.translate(issue!, translations),
          equals('Unknown error'));
    });
  });
}

const String notFound = 'notFound';

ValityRule<String?> unknownRule() => (value) => ValityIssue(code: 'unknown');

ValityRule<String?> notFoundInList(List<String> list) => (value) {
      if (list.contains(value)) return null;
      return ValityIssue(code: notFound, params: {'key': value});
    };

class MyTranslations extends DefaultValityTranslations {
  @override
  String? translateCustom(ValityIssue issue) {
    switch (issue.code) {
      case notFound:
        final key = issue.params?['key'] as String? ?? '';
        return 'Not Found $key';
      default:
        return null;
    }
  }

  @override
  String validationError() => 'Unknown error';
}
