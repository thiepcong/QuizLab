import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/question.dart';

part 'create_quiz_state.freezed.dart';

@freezed
class CreateQuizState with _$CreateQuizState {
  const CreateQuizState._();

  const factory CreateQuizState({
    @Default(false) bool isLoading,
    @Default(false) bool isImportFile,
    @Default(false) bool saveQuestionDone,
    @Default(false) bool saveQuizDone,
    String? filePath,
    @Default([]) List<String> rightAnswer,
    @Default([]) List<Question> questions,
    String? message,
    Error? error,
  }) = _CreateQuizState;
}
