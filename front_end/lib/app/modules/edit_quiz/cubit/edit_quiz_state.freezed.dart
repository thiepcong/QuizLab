// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_quiz_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditQuizState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get saveQuestionDone => throw _privateConstructorUsedError;
  bool get saveQuizDone => throw _privateConstructorUsedError;
  List<String> get rightAnswer => throw _privateConstructorUsedError;
  List<Question> get questions => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Error? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditQuizStateCopyWith<EditQuizState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditQuizStateCopyWith<$Res> {
  factory $EditQuizStateCopyWith(
          EditQuizState value, $Res Function(EditQuizState) then) =
      _$EditQuizStateCopyWithImpl<$Res, EditQuizState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool saveQuestionDone,
      bool saveQuizDone,
      List<String> rightAnswer,
      List<Question> questions,
      String? message,
      Error? error});
}

/// @nodoc
class _$EditQuizStateCopyWithImpl<$Res, $Val extends EditQuizState>
    implements $EditQuizStateCopyWith<$Res> {
  _$EditQuizStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? saveQuestionDone = null,
    Object? saveQuizDone = null,
    Object? rightAnswer = null,
    Object? questions = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      saveQuestionDone: null == saveQuestionDone
          ? _value.saveQuestionDone
          : saveQuestionDone // ignore: cast_nullable_to_non_nullable
              as bool,
      saveQuizDone: null == saveQuizDone
          ? _value.saveQuizDone
          : saveQuizDone // ignore: cast_nullable_to_non_nullable
              as bool,
      rightAnswer: null == rightAnswer
          ? _value.rightAnswer
          : rightAnswer // ignore: cast_nullable_to_non_nullable
              as List<String>,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
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
abstract class _$$EditQuizStateImplCopyWith<$Res>
    implements $EditQuizStateCopyWith<$Res> {
  factory _$$EditQuizStateImplCopyWith(
          _$EditQuizStateImpl value, $Res Function(_$EditQuizStateImpl) then) =
      __$$EditQuizStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool saveQuestionDone,
      bool saveQuizDone,
      List<String> rightAnswer,
      List<Question> questions,
      String? message,
      Error? error});
}

/// @nodoc
class __$$EditQuizStateImplCopyWithImpl<$Res>
    extends _$EditQuizStateCopyWithImpl<$Res, _$EditQuizStateImpl>
    implements _$$EditQuizStateImplCopyWith<$Res> {
  __$$EditQuizStateImplCopyWithImpl(
      _$EditQuizStateImpl _value, $Res Function(_$EditQuizStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? saveQuestionDone = null,
    Object? saveQuizDone = null,
    Object? rightAnswer = null,
    Object? questions = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$EditQuizStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      saveQuestionDone: null == saveQuestionDone
          ? _value.saveQuestionDone
          : saveQuestionDone // ignore: cast_nullable_to_non_nullable
              as bool,
      saveQuizDone: null == saveQuizDone
          ? _value.saveQuizDone
          : saveQuizDone // ignore: cast_nullable_to_non_nullable
              as bool,
      rightAnswer: null == rightAnswer
          ? _value._rightAnswer
          : rightAnswer // ignore: cast_nullable_to_non_nullable
              as List<String>,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
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

class _$EditQuizStateImpl extends _EditQuizState {
  const _$EditQuizStateImpl(
      {this.isLoading = false,
      this.saveQuestionDone = false,
      this.saveQuizDone = false,
      final List<String> rightAnswer = const [],
      final List<Question> questions = const [],
      this.message,
      this.error})
      : _rightAnswer = rightAnswer,
        _questions = questions,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool saveQuestionDone;
  @override
  @JsonKey()
  final bool saveQuizDone;
  final List<String> _rightAnswer;
  @override
  @JsonKey()
  List<String> get rightAnswer {
    if (_rightAnswer is EqualUnmodifiableListView) return _rightAnswer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rightAnswer);
  }

  final List<Question> _questions;
  @override
  @JsonKey()
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final String? message;
  @override
  final Error? error;

  @override
  String toString() {
    return 'EditQuizState(isLoading: $isLoading, saveQuestionDone: $saveQuestionDone, saveQuizDone: $saveQuizDone, rightAnswer: $rightAnswer, questions: $questions, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditQuizStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.saveQuestionDone, saveQuestionDone) ||
                other.saveQuestionDone == saveQuestionDone) &&
            (identical(other.saveQuizDone, saveQuizDone) ||
                other.saveQuizDone == saveQuizDone) &&
            const DeepCollectionEquality()
                .equals(other._rightAnswer, _rightAnswer) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      saveQuestionDone,
      saveQuizDone,
      const DeepCollectionEquality().hash(_rightAnswer),
      const DeepCollectionEquality().hash(_questions),
      message,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditQuizStateImplCopyWith<_$EditQuizStateImpl> get copyWith =>
      __$$EditQuizStateImplCopyWithImpl<_$EditQuizStateImpl>(this, _$identity);
}

abstract class _EditQuizState extends EditQuizState {
  const factory _EditQuizState(
      {final bool isLoading,
      final bool saveQuestionDone,
      final bool saveQuizDone,
      final List<String> rightAnswer,
      final List<Question> questions,
      final String? message,
      final Error? error}) = _$EditQuizStateImpl;
  const _EditQuizState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get saveQuestionDone;
  @override
  bool get saveQuizDone;
  @override
  List<String> get rightAnswer;
  @override
  List<Question> get questions;
  @override
  String? get message;
  @override
  Error? get error;
  @override
  @JsonKey(ignore: true)
  _$$EditQuizStateImplCopyWith<_$EditQuizStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
