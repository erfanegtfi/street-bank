import 'form_validation_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_state.freezed.dart';

@freezed
abstract class ViewState<T> with _$ViewState<T> {
  const factory ViewState.init() = Init<T>;
  const factory ViewState.loading() = Loading<T>;
  const factory ViewState.success(T value) = Success<T>;
  const factory ViewState.formValidation(FormValidationState validation) = FormValidation;
}
