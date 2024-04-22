// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_test_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResultTestState {
  List<Result> get results => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Error? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResultTestStateCopyWith<ResultTestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultTestStateCopyWith<$Res> {
  factory $ResultTestStateCopyWith(
          ResultTestState value, $Res Function(ResultTestState) then) =
      _$ResultTestStateCopyWithImpl<$Res, ResultTestState>;
  @useResult
  $Res call(
      {List<Result> results, bool isLoading, String? message, Error? error});
}

/// @nodoc
class _$ResultTestStateCopyWithImpl<$Res, $Val extends ResultTestState>
    implements $ResultTestStateCopyWith<$Res> {
  _$ResultTestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? isLoading = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Result>,
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
abstract class _$$ResultTestStateImplCopyWith<$Res>
    implements $ResultTestStateCopyWith<$Res> {
  factory _$$ResultTestStateImplCopyWith(_$ResultTestStateImpl value,
          $Res Function(_$ResultTestStateImpl) then) =
      __$$ResultTestStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Result> results, bool isLoading, String? message, Error? error});
}

/// @nodoc
class __$$ResultTestStateImplCopyWithImpl<$Res>
    extends _$ResultTestStateCopyWithImpl<$Res, _$ResultTestStateImpl>
    implements _$$ResultTestStateImplCopyWith<$Res> {
  __$$ResultTestStateImplCopyWithImpl(
      _$ResultTestStateImpl _value, $Res Function(_$ResultTestStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? isLoading = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$ResultTestStateImpl(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Result>,
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

class _$ResultTestStateImpl extends _ResultTestState {
  const _$ResultTestStateImpl(
      {final List<Result> results = const [],
      this.isLoading = false,
      this.message,
      this.error})
      : _results = results,
        super._();

  final List<Result> _results;
  @override
  @JsonKey()
  List<Result> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? message;
  @override
  final Error? error;

  @override
  String toString() {
    return 'ResultTestState(results: $results, isLoading: $isLoading, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultTestStateImpl &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_results), isLoading, message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultTestStateImplCopyWith<_$ResultTestStateImpl> get copyWith =>
      __$$ResultTestStateImplCopyWithImpl<_$ResultTestStateImpl>(
          this, _$identity);
}

abstract class _ResultTestState extends ResultTestState {
  const factory _ResultTestState(
      {final List<Result> results,
      final bool isLoading,
      final String? message,
      final Error? error}) = _$ResultTestStateImpl;
  const _ResultTestState._() : super._();

  @override
  List<Result> get results;
  @override
  bool get isLoading;
  @override
  String? get message;
  @override
  Error? get error;
  @override
  @JsonKey(ignore: true)
  _$$ResultTestStateImplCopyWith<_$ResultTestStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
