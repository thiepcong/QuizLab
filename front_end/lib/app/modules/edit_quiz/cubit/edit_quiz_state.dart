import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/question.dart';

part 'edit_quiz_state.freezed.dart';

@freezed
class EditQuizState with _$EditQuizState {
  const EditQuizState._();

  const factory EditQuizState({
    @Default(false) bool isLoading,
    @Default(false) bool saveQuestionDone,
    @Default(false) bool saveQuizDone,
    @Default([]) List<String> rightAnswer,
    @Default([]) List<Question> questions,
    String? message,
    Error? error,
  }) = _EditQuizState;
}
