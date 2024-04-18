// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_test_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateTestState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get createDone => throw _privateConstructorUsedError;
  List<Candidate> get candidates => throw _privateConstructorUsedError;
  String? get filePath => throw _privateConstructorUsedError;
  String? get codeQuiz => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Error? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateTestStateCopyWith<CreateTestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTestStateCopyWith<$Res> {
  factory $CreateTestStateCopyWith(
          CreateTestState value, $Res Function(CreateTestState) then) =
      _$CreateTestStateCopyWithImpl<$Res, CreateTestState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool createDone,
      List<Candidate> candidates,
      String? filePath,
      String? codeQuiz,
      String? message,
      Error? error});
}

/// @nodoc
class _$CreateTestStateCopyWithImpl<$Res, $Val extends CreateTestState>
    implements $CreateTestStateCopyWith<$Res> {
  _$CreateTestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? createDone = null,
    Object? candidates = null,
    Object? filePath = freezed,
    Object? codeQuiz = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      createDone: null == createDone
          ? _value.createDone
          : createDone // ignore: cast_nullable_to_non_nullable
              as bool,
      candidates: null == candidates
          ? _value.candidates
          : candidates // ignore: cast_nullable_to_non_nullable
              as List<Candidate>,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      codeQuiz: freezed == codeQuiz
          ? _value.codeQuiz
          : codeQuiz // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$CreateTestStateImplCopyWith<$Res>
    implements $CreateTestStateCopyWith<$Res> {
  factory _$$CreateTestStateImplCopyWith(_$CreateTestStateImpl value,
          $Res Function(_$CreateTestStateImpl) then) =
      __$$CreateTestStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool createDone,
      List<Candidate> candidates,
      String? filePath,
      String? codeQuiz,
      String? message,
      Error? error});
}

/// @nodoc
class __$$CreateTestStateImplCopyWithImpl<$Res>
    extends _$CreateTestStateCopyWithImpl<$Res, _$CreateTestStateImpl>
    implements _$$CreateTestStateImplCopyWith<$Res> {
  __$$CreateTestStateImplCopyWithImpl(
      _$CreateTestStateImpl _value, $Res Function(_$CreateTestStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? createDone = null,
    Object? candidates = null,
    Object? filePath = freezed,
    Object? codeQuiz = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$CreateTestStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      createDone: null == createDone
          ? _value.createDone
          : createDone // ignore: cast_nullable_to_non_nullable
              as bool,
      candidates: null == candidates
          ? _value._candidates
          : candidates // ignore: cast_nullable_to_non_nullable
              as List<Candidate>,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      codeQuiz: freezed == codeQuiz
          ? _value.codeQuiz
          : codeQuiz // ignore: cast_nullable_to_non_nullable
              as String?,
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

class _$CreateTestStateImpl extends _CreateTestState {
  const _$CreateTestStateImpl(
      {this.isLoading = false,
      this.createDone = false,
      final List<Candidate> candidates = const [],
      this.filePath,
      this.codeQuiz,
      this.message,
      this.error})
      : _candidates = candidates,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool createDone;
  final List<Candidate> _candidates;
  @override
  @JsonKey()
  List<Candidate> get candidates {
    if (_candidates is EqualUnmodifiableListView) return _candidates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_candidates);
  }

  @override
  final String? filePath;
  @override
  final String? codeQuiz;
  @override
  final String? message;
  @override
  final Error? error;

  @override
  String toString() {
    return 'CreateTestState(isLoading: $isLoading, createDone: $createDone, candidates: $candidates, filePath: $filePath, codeQuiz: $codeQuiz, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTestStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.createDone, createDone) ||
                other.createDone == createDone) &&
            const DeepCollectionEquality()
                .equals(other._candidates, _candidates) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.codeQuiz, codeQuiz) ||
                other.codeQuiz == codeQuiz) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      createDone,
      const DeepCollectionEquality().hash(_candidates),
      filePath,
      codeQuiz,
      message,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTestStateImplCopyWith<_$CreateTestStateImpl> get copyWith =>
      __$$CreateTestStateImplCopyWithImpl<_$CreateTestStateImpl>(
          this, _$identity);
}

abstract class _CreateTestState extends CreateTestState {
  const factory _CreateTestState(
      {final bool isLoading,
      final bool createDone,
      final List<Candidate> candidates,
      final String? filePath,
      final String? codeQuiz,
      final String? message,
      final Error? error}) = _$CreateTestStateImpl;
  const _CreateTestState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get createDone;
  @override
  List<Candidate> get candidates;
  @override
  String? get filePath;
  @override
  String? get codeQuiz;
  @override
  String? get message;
  @override
  Error? get error;
  @override
  @JsonKey(ignore: true)
  _$$CreateTestStateImplCopyWith<_$CreateTestStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
