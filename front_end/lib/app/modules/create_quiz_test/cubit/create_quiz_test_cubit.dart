import 'dart:developer';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/answer.dart';
import '../../../core/models/candidate.dart';
import '../../../core/models/question.dart';
import '../../../core/models/quiz.dart';
import '../repository/create_quiz_test_repository.dart';
import 'create_quiz_test_state.dart';

class CreateQuizTestCubit extends Cubit<CreateQuizTestState> {
  CreateQuizTestCubit(this._repo) : super(const CreateQuizTestState());

  final CreateQuizTestRepository _repo;

  void createQuizAndTest(
    String subject,
    String title,
    int time,
    String titleTest,
    String? note,
    String timeStart,
    String timeEnd,
  ) async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      if (state.questions.isEmpty) {
        emit(state.copyWith(
          message: "Vui lòng thêm ít nhất một câu hỏi",
          isLoading: false,
        ));
        return;
      }
      final res = await createQuiz(subject, title, time);
      createTest(res.id, titleTest, note, timeStart, timeEnd);
    } catch (e) {
      emit(state.copyWith(message: "Đã có lỗi xảy ra", isLoading: false));
    }
  }

  Future<Quiz> createQuiz(String subject, String title, int time) async {
    try {
      final res = await _repo.createQuiz(
        subject: subject,
        title: title,
        time: time,
        questions: state.questions,
      );
      return res;
    } catch (e) {
      emit(state.copyWith(message: "Đã có lỗi xảy ra", isLoading: false));
      rethrow;
    }
  }

  void chooseFileExcel(Uint8List? bytes, String fileName) {
    if (bytes == null) return;
    try {
      emit(state.copyWith(message: null, isImportFile: false, isLoading: true));
      var excel = Excel.decodeBytes(bytes);
      List<Question> li = [];
      for (final table in excel.tables.keys) {
        log(table);
        for (final row in excel.tables[table]!.rows) {
          // for (final cell in row) {
          //   log(cell?.value.toString() ?? '');
          // }
          li.add(Question(content: row[0]!.value.toString(), answers: [
            Answer(
                content: row[1]!.value.toString(),
                status: bool.parse(row[5]!.value.toString())),
            Answer(
                content: row[2]!.value.toString(),
                status: bool.parse(row[6]!.value.toString())),
            Answer(
                content: row[3]!.value.toString(),
                status: bool.parse(row[7]!.value.toString())),
            Answer(
                content: row[4]!.value.toString(),
                status: bool.parse(row[8]!.value.toString())),
          ]));
        }
      }
      emit(state.copyWith(
        questions: li,
        isImportFile: true,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(message: "Vui lòng thử lại", isLoading: false));
      rethrow;
    }
  }

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
      isImportFile: false,
    ));
  }

  void deleteQuestion(Question item) {
    List<Question> res = List.from(state.questions);
    res.remove(item);
    emit(state.copyWith(questions: res, isImportFile: false));
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
      isImportFile: false,
    ));
  }

  void createTest(
    int quizId,
    String title,
    String? note,
    String timeStart,
    String timeEnd,
  ) async {
    try {
      final pre = await SharedPreferences.getInstance();
      await pre.setInt("quizId", quizId);
      await pre.setString("timeStart", timeStart);
      await pre.setString("timeEnd", timeEnd);
      emit(state.copyWith(message: null, isLoading: true, createDone: false));
      if (state.candidates.isEmpty) {
        emit(state.copyWith(
          message: "vui lòng thêm ít nhất một người",
          isLoading: false,
        ));
        return;
      }
      final res = await _repo.createTest(
        title: title,
        note: note,
        candidates: state.candidates,
      );
      await pre.remove("quizId");
      await pre.remove("timeStart");
      await pre.remove("timeEnd");
      emit(state.copyWith(
        isLoading: false,
        codeQuiz: res.quizCode,
        createDone: true,
      ));
    } catch (e) {
      final pre = await SharedPreferences.getInstance();
      await pre.remove("quizId");
      await pre.remove("timeStart");
      await pre.remove("timeEnd");
      emit(state.copyWith(message: "Đã có lỗi xảy ra", isLoading: false));
      rethrow;
    }
  }

  void chooseCandidateFromExcel(Uint8List? bytes, String fileName) {
    if (bytes == null) return;
    try {
      emit(state.copyWith(message: null, isLoading: true));
      var excel = Excel.decodeBytes(bytes);
      List<Candidate> li = [];
      for (final table in excel.tables.keys) {
        log(table);
        for (final row in excel.tables[table]!.rows) {
          li.add(Candidate(name: row[0]!.value.toString()));
        }
      }
      emit(state.copyWith(
        candidates: li,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(message: "Vui lòng thử lại", isLoading: false));
      rethrow;
    }
  }

  void addCandidate(String e) {
    List<Candidate> li = List.from(state.candidates);
    li.add(Candidate(name: e));
    emit(state.copyWith(candidates: li));
  }

  void deleteCandidate(Candidate e) {
    List<Candidate> li = List.from(state.candidates);
    li.remove(e);
    emit(state.copyWith(candidates: li));
  }
}
