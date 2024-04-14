import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/answer.dart';
import '../../../core/models/question.dart';
import 'create_quiz_state.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  CreateQuizCubit() : super(const CreateQuizState());

  void setRightAnswer(bool? e, String choice) {
    List<String> li = List.from(state.rightAnswer);
    if (e == true) {
      li.add(choice);
    } else if (e == false && li.contains(choice)) {
      li.remove(choice);
    }
    emit(state.copyWith(rightAnswer: li));
  }

  void saveQuestion(
    String question,
    String answerA,
    String answerB,
    String answerC,
    String answerD,
  ) {
    emit(state.copyWith(saveQuestionDone: false));
    List<String> li = List.from(state.rightAnswer);
    final item = Question(
      content: question,
      answers: [
        Answer(content: answerA, status: li.contains('A')),
        Answer(content: answerB, status: li.contains('B')),
        Answer(content: answerC, status: li.contains('C')),
        Answer(content: answerD, status: li.contains('D')),
      ],
    );
    List<Question> res = List.from(state.questions);
    res.add(item);
    emit(state.copyWith(
      questions: res,
      rightAnswer: [],
      saveQuestionDone: true,
    ));
  }

  void deleteQuestion(Question item) {
    List<Question> res = List.from(state.questions);
    res.remove(item);
    emit(state.copyWith(questions: res));
  }

  void initEdit(Question item) {
    List<String> li = [];
    if (item.answers[0].status) li.add('A');
    if (item.answers[1].status) li.add('B');
    if (item.answers[2].status) li.add('C');
    if (item.answers[3].status) li.add('D');
    emit(state.copyWith(rightAnswer: li));
  }

  void editQuestion(
    int index,
    String question,
    String answerA,
    String answerB,
    String answerC,
    String answerD,
  ) {
    emit(state.copyWith(saveQuestionDone: false));
    List<String> li = List.from(state.rightAnswer);
    final item = Question(
      content: question,
      answers: [
        Answer(content: answerA, status: li.contains('A')),
        Answer(content: answerB, status: li.contains('B')),
        Answer(content: answerC, status: li.contains('C')),
        Answer(content: answerD, status: li.contains('D')),
      ],
    );
    List<Question> res = List.from(state.questions);
    res[index] = item;
    emit(state.copyWith(
      questions: res,
      rightAnswer: [],
      saveQuestionDone: true,
    ));
  }
}
