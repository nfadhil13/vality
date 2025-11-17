import 'package:example_bloc/l10n/app_localizations.dart';
import 'package:example_bloc/localization/app_localizations_adapter.dart';
import 'package:flutter/material.dart';
import 'package:vality/vality.dart';

/// Helper class for Flutter-specific integration with vality translations
///
/// This provides convenience methods for using vality translations
/// with Flutter's BuildContext and AppLocalizations.
class ValityLocalizationsHelper {
  /// Translate a ValityIssue with automatic fallback
  ///
  /// Tries to use AppLocalizations if available, otherwise falls back
  /// to default English translations from the library.
  ///
  /// **Usage:**
  /// ```dart
  /// final errorMessage = ValityLocalizationsHelper.translateWithFallback(
  ///   issue,
  ///   context,
  /// );
  /// ```
  static String translateWithFallback(
    ValityIssue issue,
    BuildContext context,
  ) {
    final appLocalizations = AppLocalizations.of(context);
    if (appLocalizations != null) {
      return ValityTranslationsHelper.translate(
        issue,
        appLocalizations.toValityTranslations(),
      );
    }
    return ValityTranslationsHelper.translateDefault(issue);
  }
}

/// Extension methods for ValityField to get error messages in Flutter
extension ValityFieldFlutterExtension<T> on ValityField<T> {
  /// Get localized error message with automatic fallback
  ///
  /// Uses AppLocalizations if available, otherwise falls back to
  /// default English translations from the library.
  ///
  /// **Usage:**
  /// ```dart
  /// TextFormField(
  ///   decoration: InputDecoration(
  ///     errorText: field.errorMessage(context),
  ///   ),
  /// )
  /// ```
  String? errorMessage(BuildContext context) {
    if (issue == null) return null;
    return ValityLocalizationsHelper.translateWithFallback(issue!, context);
  }

  /// Get error message using AppLocalizations (throws if not available)
  ///
  /// **Usage:**
  /// ```dart
  /// final appLocalizations = AppLocalizations.of(context)!;
  /// final error = field.errorMessageLocalized(appLocalizations);
  /// ```
  String? errorMessageLocalized(AppLocalizations appLocalizations) {
    if (issue == null) return null;
    return ValityTranslationsHelper.translate(
      issue!,
      appLocalizations.toValityTranslations(),
    );
  }

  /// Get error message using default English translations
  ///
  /// **Usage:**
  /// ```dart
  /// final error = field.errorMessageDefault();
  /// ```
  String? errorMessageDefault() {
    if (issue == null) return null;
    return ValityTranslationsHelper.translateDefault(issue!);
  }
}
