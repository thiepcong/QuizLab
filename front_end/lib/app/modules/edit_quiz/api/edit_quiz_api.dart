import '../../../core/base/base_remote_source.dart';
import '../../../core/models/question.dart';
import '../../../core/models/quiz.dart';
import '../../../core/values/api_url_constant.dart';

class EditQuizApi extends BaseRemoteSource {
  Future<Quiz> editQuiz({
    required int id,
    required String subject,
    required String title,
    required int time,
    required List<Question> questions,
  }) async {
    final request = dioClient.put(ApiUrlConstants.editQuiz(id), data: {
      "subject": subject,
      "title": title,
      "time": time,
      "questions": questions.map((e) => e.toJson()).toList(),
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => Quiz.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }
}
