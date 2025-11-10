import 'package:equatable/equatable.dart';

/// {@template vality_issue}
/// A issue that can be returned by a vality rule.
/// The class contains the code of the issue
///
///
/// ```
/// ```
/// {@endtemplate}
class ValityIssue extends Equatable {
  /// {@template vality_issue_code}
  /// The code representing validation issue
  /// May return a Harcoded String or a String represent a key in a translation file
  /// {@endtemplate}
  final String code;
  // final Map<String, dynamic>? params;

  const ValityIssue({required this.code});

  @override
  List<Object?> get props => [code];
}
