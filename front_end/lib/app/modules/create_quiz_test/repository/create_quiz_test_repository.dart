import '../../../core/models/candidate.dart';
import '../../../core/models/question.dart';
import '../../../core/models/quiz.dart';
import '../../../core/models/test.dart';
import '../api/create_quiz_test_api.dart';

class CreateQuizTestRepository {
  final CreateQuizTestApi _api;

  CreateQuizTestRepository(this._api);

  Future<Quiz> createQuiz({
    required String subject,
    required String title,
    required int time,
    required List<Question> questions,
  }) async {
    return _api.createQuiz(
      subject: subject,
      title: title,
      time: time,
      questions: questions,
    );
  }

  Future<Test> createTest({
    required String title,
    String? note,
    required List<Candidate> candidates,
  }) async {
    return _api.createTest(
      title: title,
      candidates: candidates,
      note: note,
    );
  }
}
