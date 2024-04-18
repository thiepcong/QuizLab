import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/quiz.dart';
import 'play_test_state.dart';

class PlayTestCubit extends Cubit<PlayTestState> {
  PlayTestCubit() : super(const PlayTestState());

  int deadlineOfQuestion = 0;
  Timer? timer;

  void setChooseCandidate(String? chooseCandidate) {
    emit(state.copyWith(chooseCandidate: chooseCandidate));
  }

  void initPlayTest(Quiz quiz) {
    deadlineOfQuestion = quiz.time;
    emit(state.copyWith(questions: quiz.questions));
  }

  void reset() {
    emit(state.copyWith(
      secondCountdown: deadlineOfQuestion,
      isChooseA: false,
      isChooseB: false,
      isChooseC: false,
      isChooseD: false,
    ));
  }

  void startCountDown() {
    try {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.secondCountdown > 0) {
          emit(state.copyWith(secondCountdown: state.secondCountdown - 1));
        } else {
          timer.cancel();
        }
      });
    } catch (e) {
      stopCountDown();
    }
  }

  void stopCountDown() {
    timer?.cancel();
    timer = null;
  }
}
