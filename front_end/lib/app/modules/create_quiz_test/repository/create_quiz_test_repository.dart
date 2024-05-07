import '../../../core/models/candidate.dart';
import '../../../core/models/question.dart';
import '../../../core/models/test.dart';
import '../api/create_quiz_test_api.dart';

class CreateQuizTestRepository {
  final CreateQuizTestApi _api;

  CreateQuizTestRepository(this._api);

  Future<Test> createTest({
    required String titleQuiz,
    required DateTime timeStart,
    required DateTime timeEnd,
    String? note,
    required int time,
    required String subject,
    required String titleTest,
    required List<Question> questions,
    required List<Candidate> candidates,
  }) async {
    return _api.createTest(
      titleQuiz: titleQuiz,
      timeStart: timeStart,
      timeEnd: timeEnd,
      time: time,
      note: note,
      subject: subject,
      titleTest: titleTest,
      questions: questions,
      candidates: candidates,
    );
  }

  Future<Test> createTestFromExcel({
    required String quizTitle,
    required String subject,
    required String testTitle,
    String? testNote,
    required int time,
  }) async {
    return _api.createTestFromExcel(
      quizTitle: quizTitle,
      subject: subject,
      testTitle: testTitle,
      time: time,
      testNote: testNote,
    );
  }
}
