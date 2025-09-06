// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ViewState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ViewState<$T>()';
}


}

/// @nodoc
class $ViewStateCopyWith<T,$Res>  {
$ViewStateCopyWith(ViewState<T> _, $Res Function(ViewState<T>) __);
}


/// Adds pattern-matching-related methods to [ViewState].
extension ViewStatePatterns<T> on ViewState<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Init<T> value)?  init,TResult Function( Loading<T> value)?  loading,TResult Function( Success<T> value)?  success,TResult Function( FormValidation<T> value)?  formValidation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Init() when init != null:
return init(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case FormValidation() when formValidation != null:
return formValidation(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Init<T> value)  init,required TResult Function( Loading<T> value)  loading,required TResult Function( Success<T> value)  success,required TResult Function( FormValidation<T> value)  formValidation,}){
final _that = this;
switch (_that) {
case Init():
return init(_that);case Loading():
return loading(_that);case Success():
return success(_that);case FormValidation():
return formValidation(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Init<T> value)?  init,TResult? Function( Loading<T> value)?  loading,TResult? Function( Success<T> value)?  success,TResult? Function( FormValidation<T> value)?  formValidation,}){
final _that = this;
switch (_that) {
case Init() when init != null:
return init(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case FormValidation() when formValidation != null:
return formValidation(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function()?  loading,TResult Function( T value)?  success,TResult Function( FormValidationState validation)?  formValidation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Init() when init != null:
return init();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.value);case FormValidation() when formValidation != null:
return formValidation(_that.validation);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function()  loading,required TResult Function( T value)  success,required TResult Function( FormValidationState validation)  formValidation,}) {final _that = this;
switch (_that) {
case Init():
return init();case Loading():
return loading();case Success():
return success(_that.value);case FormValidation():
return formValidation(_that.validation);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function()?  loading,TResult? Function( T value)?  success,TResult? Function( FormValidationState validation)?  formValidation,}) {final _that = this;
switch (_that) {
case Init() when init != null:
return init();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.value);case FormValidation() when formValidation != null:
return formValidation(_that.validation);case _:
  return null;

}
}

}

/// @nodoc


class Init<T> implements ViewState<T> {
  const Init();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Init<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ViewState<$T>.init()';
}


}




/// @nodoc


class Loading<T> implements ViewState<T> {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ViewState<$T>.loading()';
}


}




/// @nodoc


class Success<T> implements ViewState<T> {
  const Success(this.value);
  

 final  T value;

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<T, Success<T>> get copyWith => _$SuccessCopyWithImpl<T, Success<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success<T>&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'ViewState<$T>.success(value: $value)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<T,$Res> implements $ViewStateCopyWith<T, $Res> {
  factory $SuccessCopyWith(Success<T> value, $Res Function(Success<T>) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 T value
});




}
/// @nodoc
class _$SuccessCopyWithImpl<T,$Res>
    implements $SuccessCopyWith<T, $Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success<T> _self;
  final $Res Function(Success<T>) _then;

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(Success<T>(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class FormValidation<T> implements ViewState<T> {
  const FormValidation(this.validation);
  

 final  FormValidationState validation;

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormValidationCopyWith<T, FormValidation<T>> get copyWith => _$FormValidationCopyWithImpl<T, FormValidation<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormValidation<T>&&(identical(other.validation, validation) || other.validation == validation));
}


@override
int get hashCode => Object.hash(runtimeType,validation);

@override
String toString() {
  return 'ViewState<$T>.formValidation(validation: $validation)';
}


}

/// @nodoc
abstract mixin class $FormValidationCopyWith<T,$Res> implements $ViewStateCopyWith<T, $Res> {
  factory $FormValidationCopyWith(FormValidation<T> value, $Res Function(FormValidation<T>) _then) = _$FormValidationCopyWithImpl;
@useResult
$Res call({
 FormValidationState validation
});




}
/// @nodoc
class _$FormValidationCopyWithImpl<T,$Res>
    implements $FormValidationCopyWith<T, $Res> {
  _$FormValidationCopyWithImpl(this._self, this._then);

  final FormValidation<T> _self;
  final $Res Function(FormValidation<T>) _then;

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? validation = null,}) {
  return _then(FormValidation<T>(
null == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as FormValidationState,
  ));
}


}

// dart format on
