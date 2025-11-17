import 'package:vality/vality.dart';

abstract class ValityForm {
  List<ValityField<dynamic>> get fields;

  bool get isValid => fields.every((field) => field.isValid);

  List<ValityIssue> get issues => fields
      .map((field) => field.issue)
      .where((issue) => issue != null)
      .cast<ValityIssue>()
      .toList();
}
