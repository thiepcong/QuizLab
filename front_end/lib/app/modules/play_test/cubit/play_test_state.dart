import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/question.dart';

part 'play_test_state.freezed.dart';

@freezed
class PlayTestState with _$PlayTestState {
  const PlayTestState._();

  const factory PlayTestState({
    @Default(false) bool isLoading,
    @Default(false) bool isChooseA,
    @Default(false) bool isChooseB,
    @Default(false) bool isChooseC,
    @Default(false) bool isChooseD,
    @Default(false) bool isTrueA,
    @Default(false) bool isTrueB,
    @Default(false) bool isTrueC,
    @Default(false) bool isTrueD,
    @Default(false) bool isFalse,
    @Default(false) bool isMultipleChoice,
    @Default(false) bool isPLayDone,
    String? chooseCandidate,
    @Default(0) int secondCountdown,
    Question? currentQuestion,
    @Default(0) int currentIndexQuestion,
    @Default([]) List<Question> questions,
    String? message,
    Error? error,
  }) = _PlayTestState;
}
