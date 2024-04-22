import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/candidate.dart';
import '../../../core/models/test.dart';
import 'play_test_state.dart';

class PlayTestCubit extends Cubit<PlayTestState> {
  PlayTestCubit() : super(const PlayTestState());

  int deadlineOfQuestion = 0;
  int right = 0;
  Timer? timer;

  void setChooseCandidate(String? chooseCandidate, List<Candidate> candidates) {
    Candidate? item;
    for (final i in candidates) {
      if (i.name == chooseCandidate) {
        item = i;
        break;
      }
    }
    emit(state.copyWith(chooseCandidate: item));
  }

  void initPlayTest(Test test) {
    final quiz = test.quiz;
    deadlineOfQuestion = quiz.time;
    emit(state.copyWith(
      questions: quiz.questions,
      currentQuestion: quiz.questions[0],
      secondCountdown: test.quiz.time,
    ));
    startCountDown();
  }

  void reset() {
    emit(state.copyWith(
      secondCountdown: deadlineOfQuestion,
      isChooseA: false,
      isChooseB: false,
      isChooseC: false,
      isChooseD: false,
      isTrueA: false,
      isTrueB: false,
      isTrueC: false,
      isTrueD: false,
      isFalse: false,
    ));
  }

  void chooseAnswer(String type) async {
    stopCountDown();
    switch (type) {
      case 'A':
        emit(state.copyWith(isChooseA: true));
        break;
      case 'B':
        emit(state.copyWith(isChooseB: true));
        break;
      case 'C':
        emit(state.copyWith(isChooseC: true));
        break;
      default:
        emit(state.copyWith(isChooseD: true));
        break;
    }
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(
      isTrueA: state.currentQuestion!.answers[0].status,
      isTrueB: state.currentQuestion!.answers[1].status,
      isTrueC: state.currentQuestion!.answers[2].status,
      isTrueD: state.currentQuestion!.answers[3].status,
      isFalse: !checkAnswer(),
    ));
    if (checkAnswer()) right++;
    // emit(state.copyWith(isFalse: !checkAnswer()));
    await Future.delayed(const Duration(seconds: 1));
    if (state.currentIndexQuestion < state.questions.length - 1) {
      emit(state.copyWith(
        currentQuestion: state.questions[state.currentIndexQuestion + 1],
        currentIndexQuestion: state.currentIndexQuestion + 1,
      ));
      emit(state.copyWith(isMultipleChoice: checkMultipleChoise()));
      reset();
      startCountDown();
    } else {
      emit(state.copyWith(isPLayDone: true));
    }
  }

  bool checkMultipleChoise() {
    final res = state.currentQuestion;
    if (res == null) return false;
    int dem = 0;
    for (final i in res.answers) {
      if (i.status) dem++;
    }
    return dem > 1;
  }

  bool checkAnswer() {
    final res = state.currentQuestion;
    if (res == null) return false;
    return res.answers[0].status == state.isChooseA &&
        res.answers[1].status == state.isChooseB &&
        res.answers[2].status == state.isChooseC &&
        res.answers[3].status == state.isChooseD;
  }

  void startCountDown() {
    try {
      stopCountDown();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.secondCountdown > 0) {
          try {
            emit(state.copyWith(secondCountdown: state.secondCountdown - 1));
          } catch (e) {
            stopCountDown();
            if (state is StateError) return;
          }
        } else {
          timer.cancel();
        }
      });
    } catch (e) {
      stopCountDown();
      if (state is StateError) return;
    }
  }

  void stopCountDown() {
    timer?.cancel();
    timer = null;
  }

  void setCheckBoxAnswer(String type, bool? e) {
    switch (type) {
      case 'A':
        emit(state.copyWith(isChooseA: e ?? !state.isChooseA));
        break;
      case 'B':
        emit(state.copyWith(isChooseB: e ?? !state.isChooseB));
        break;
      case 'C':
        emit(state.copyWith(isChooseC: e ?? !state.isChooseC));
        break;
      default:
        emit(state.copyWith(isChooseD: e ?? !state.isChooseD));
        break;
    }
  }

  void handleNext() async {
    if (state.isMultipleChoice) {
      stopCountDown();
      emit(state.copyWith(isMultipleChoice: false));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        isTrueA: state.currentQuestion!.answers[0].status,
        isTrueB: state.currentQuestion!.answers[1].status,
        isTrueC: state.currentQuestion!.answers[2].status,
        isTrueD: state.currentQuestion!.answers[3].status,
        isFalse: !checkAnswer(),
      ));
      if (checkAnswer()) right++;
      await Future.delayed(const Duration(seconds: 1));
      if (state.currentIndexQuestion < state.questions.length - 1) {
        emit(state.copyWith(
          currentQuestion: state.questions[state.currentIndexQuestion + 1],
          currentIndexQuestion: state.currentIndexQuestion + 1,
        ));
        emit(state.copyWith(isMultipleChoice: checkMultipleChoise()));
        reset();
        startCountDown();
      } else {
        emit(state.copyWith(isPLayDone: true));
      }
    }
  }

  void endTime() async {
    emit(state.copyWith(
      isTrueA: state.currentQuestion!.answers[0].status,
      isTrueB: state.currentQuestion!.answers[1].status,
      isTrueC: state.currentQuestion!.answers[2].status,
      isTrueD: state.currentQuestion!.answers[3].status,
      isFalse: !checkAnswer(),
    ));
    // emit(state.copyWith(isFalse: !checkAnswer()));
    await Future.delayed(const Duration(seconds: 1));
    if (state.currentIndexQuestion < state.questions.length - 1) {
      emit(state.copyWith(
        currentQuestion: state.questions[state.currentIndexQuestion + 1],
        currentIndexQuestion: state.currentIndexQuestion + 1,
      ));
      emit(state.copyWith(isMultipleChoice: checkMultipleChoise()));
      reset();
      startCountDown();
    } else {
      emit(state.copyWith(isPLayDone: true));
    }
  }
}
