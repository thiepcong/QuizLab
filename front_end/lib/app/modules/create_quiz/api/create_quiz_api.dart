import '../../../core/base/base_remote_source.dart';
import '../../../core/models/question.dart';
import '../../../core/models/quiz.dart';
import '../../../core/values/api_url_constant.dart';

class CreateQuizApi extends BaseRemoteSource {
  Future<Quiz> createQuizFromExcel({
    required String subject,
    required String title,
    required int time,
  }) async {
    final request = dioClient.post(ApiUrlConstants.createQuizFromExcel, data: {
      "subject": subject,
      "title": title,
      "time": time,
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => Quiz.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<Quiz> createQuiz({
    required String subject,
    required String title,
    required int time,
    required List<Question> questions,
  }) async {
    final request = dioClient.post(ApiUrlConstants.createQuiz, data: {
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
