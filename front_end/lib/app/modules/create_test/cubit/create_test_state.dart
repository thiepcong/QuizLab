import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/candidate.dart';

part 'create_test_state.freezed.dart';

@freezed
class CreateTestState with _$CreateTestState {
  const CreateTestState._();

  const factory CreateTestState({
    @Default(false) bool isLoading,
    @Default(false) bool createDone,
    @Default([]) List<Candidate> candidates,
    String? filePath,
    String? codeQuiz,
    String? message,
    Error? error,
  }) = _CreateTestState;
}
