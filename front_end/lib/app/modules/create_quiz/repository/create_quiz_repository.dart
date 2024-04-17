import '../../../core/models/question.dart';
import '../../../core/models/quiz.dart';
import '../api/create_quiz_api.dart';

class CreateQuizRepository {
  final CreateQuizApi _api;

  CreateQuizRepository(this._api);

  Future<Quiz> createQuizFromExcel({
    required String subject,
    required String title,
    required int time,
  }) async {
    return _api.createQuizFromExcel(
      subject: subject,
      title: title,
      time: time,
    );
  }

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
}
