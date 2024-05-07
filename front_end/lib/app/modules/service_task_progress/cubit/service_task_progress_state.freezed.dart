// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_task_progress_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ServiceTaskProgressState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<String> get progress => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Error? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ServiceTaskProgressStateCopyWith<ServiceTaskProgressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceTaskProgressStateCopyWith<$Res> {
  factory $ServiceTaskProgressStateCopyWith(ServiceTaskProgressState value,
          $Res Function(ServiceTaskProgressState) then) =
      _$ServiceTaskProgressStateCopyWithImpl<$Res, ServiceTaskProgressState>;
  @useResult
  $Res call(
      {bool isLoading, List<String> progress, String? message, Error? error});
}

/// @nodoc
class _$ServiceTaskProgressStateCopyWithImpl<$Res,
        $Val extends ServiceTaskProgressState>
    implements $ServiceTaskProgressStateCopyWith<$Res> {
  _$ServiceTaskProgressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? progress = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
abstract class _$$ServiceTaskProgressStateImplCopyWith<$Res>
    implements $ServiceTaskProgressStateCopyWith<$Res> {
  factory _$$ServiceTaskProgressStateImplCopyWith(
          _$ServiceTaskProgressStateImpl value,
          $Res Function(_$ServiceTaskProgressStateImpl) then) =
      __$$ServiceTaskProgressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading, List<String> progress, String? message, Error? error});
}

/// @nodoc
class __$$ServiceTaskProgressStateImplCopyWithImpl<$Res>
    extends _$ServiceTaskProgressStateCopyWithImpl<$Res,
        _$ServiceTaskProgressStateImpl>
    implements _$$ServiceTaskProgressStateImplCopyWith<$Res> {
  __$$ServiceTaskProgressStateImplCopyWithImpl(
      _$ServiceTaskProgressStateImpl _value,
      $Res Function(_$ServiceTaskProgressStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? progress = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$ServiceTaskProgressStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      progress: null == progress
          ? _value._progress
          : progress // ignore: cast_nullable_to_non_nullable
              as List<String>,
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

class _$ServiceTaskProgressStateImpl extends _ServiceTaskProgressState {
  const _$ServiceTaskProgressStateImpl(
      {this.isLoading = false,
      final List<String> progress = const [],
      this.message,
      this.error})
      : _progress = progress,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<String> _progress;
  @override
  @JsonKey()
  List<String> get progress {
    if (_progress is EqualUnmodifiableListView) return _progress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_progress);
  }

  @override
  final String? message;
  @override
  final Error? error;

  @override
  String toString() {
    return 'ServiceTaskProgressState(isLoading: $isLoading, progress: $progress, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceTaskProgressStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._progress, _progress) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_progress), message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceTaskProgressStateImplCopyWith<_$ServiceTaskProgressStateImpl>
      get copyWith => __$$ServiceTaskProgressStateImplCopyWithImpl<
          _$ServiceTaskProgressStateImpl>(this, _$identity);
}

abstract class _ServiceTaskProgressState extends ServiceTaskProgressState {
  const factory _ServiceTaskProgressState(
      {final bool isLoading,
      final List<String> progress,
      final String? message,
      final Error? error}) = _$ServiceTaskProgressStateImpl;
  const _ServiceTaskProgressState._() : super._();

  @override
  bool get isLoading;
  @override
  List<String> get progress;
  @override
  String? get message;
  @override
  Error? get error;
  @override
  @JsonKey(ignore: true)
  _$$ServiceTaskProgressStateImplCopyWith<_$ServiceTaskProgressStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
