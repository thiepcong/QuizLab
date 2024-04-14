// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_quiz_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateQuizState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Error? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateQuizStateCopyWith<CreateQuizState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateQuizStateCopyWith<$Res> {
  factory $CreateQuizStateCopyWith(
          CreateQuizState value, $Res Function(CreateQuizState) then) =
      _$CreateQuizStateCopyWithImpl<$Res, CreateQuizState>;
  @useResult
  $Res call({bool isLoading, String? message, Error? error});
}

/// @nodoc
class _$CreateQuizStateCopyWithImpl<$Res, $Val extends CreateQuizState>
    implements $CreateQuizStateCopyWith<$Res> {
  _$CreateQuizStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateQuizStateImplCopyWith<$Res>
    implements $CreateQuizStateCopyWith<$Res> {
  factory _$$CreateQuizStateImplCopyWith(_$CreateQuizStateImpl value,
          $Res Function(_$CreateQuizStateImpl) then) =
      __$$CreateQuizStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? message, Error? error});
}

/// @nodoc
class __$$CreateQuizStateImplCopyWithImpl<$Res>
    extends _$CreateQuizStateCopyWithImpl<$Res, _$CreateQuizStateImpl>
    implements _$$CreateQuizStateImplCopyWith<$Res> {
  __$$CreateQuizStateImplCopyWithImpl(
      _$CreateQuizStateImpl _value, $Res Function(_$CreateQuizStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$CreateQuizStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
    ));
  }
}

/// @nodoc

class _$CreateQuizStateImpl extends _CreateQuizState {
  const _$CreateQuizStateImpl(
      {this.isLoading = false, this.message, this.error})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? message;
  @override
  final Error? error;

  @override
  String toString() {
    return 'CreateQuizState(isLoading: $isLoading, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateQuizStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateQuizStateImplCopyWith<_$CreateQuizStateImpl> get copyWith =>
      __$$CreateQuizStateImplCopyWithImpl<_$CreateQuizStateImpl>(
          this, _$identity);
}

abstract class _CreateQuizState extends CreateQuizState {
  const factory _CreateQuizState(
      {final bool isLoading,
      final String? message,
      final Error? error}) = _$CreateQuizStateImpl;
  const _CreateQuizState._() : super._();

  @override
  bool get isLoading;
  @override
  String? get message;
  @override
  Error? get error;
  @override
  @JsonKey(ignore: true)
  _$$CreateQuizStateImplCopyWith<_$CreateQuizStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
