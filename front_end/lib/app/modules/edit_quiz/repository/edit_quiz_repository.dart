import '../../../core/models/question.dart';
import '../../../core/models/quiz.dart';
import '../api/edit_quiz_api.dart';

class EditQuizRepository {
  final EditQuizApi _api;

  EditQuizRepository(this._api);

  Future<Quiz> editQuiz({
    required int id,
    required String subject,
    required String title,
    required int time,
    required List<Question> questions,
  }) async {
    return _api.editQuiz(
      id: id,
      subject: subject,
      title: title,
      time: time,
      questions: questions,
    );
  }
}
