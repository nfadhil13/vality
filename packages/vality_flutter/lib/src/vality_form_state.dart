import 'package:equatable/equatable.dart';
import 'package:vality/vality.dart';

abstract class ValityFormState<T extends ValityFormState<T>> extends Equatable {
  const ValityFormState();

  T copyWith();

  List<ValityField> get fields;

  @override
  List<Object?> get props => fields;
}
