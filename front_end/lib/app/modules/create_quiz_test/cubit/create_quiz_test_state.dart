import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/candidate.dart';
import '../../../core/models/question.dart';

part 'create_quiz_test_state.freezed.dart';

@freezed
class CreateQuizTestState with _$CreateQuizTestState {
  const CreateQuizTestState._();

  const factory CreateQuizTestState({
    @Default(false) bool isLoading,
    @Default(false) bool isImportFile,
    @Default(false) bool saveQuestionDone,
    String? quizFilePath,
    String? testFilePath,
    @Default([]) List<String> rightAnswer,
    @Default([]) List<Question> questions,
    @Default(false) bool createDone,
    @Default([]) List<Candidate> candidates,
    String? filePathCandidate,
    String? codeQuiz,
    String? message,
    Error? error,
  }) = _CreateQuizTestState;
}
