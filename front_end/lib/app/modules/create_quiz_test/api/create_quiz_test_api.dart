import '../../../core/base/base_remote_source.dart';
import '../../../core/models/candidate.dart';
import '../../../core/models/question.dart';
import '../../../core/models/quiz.dart';
import '../../../core/models/test.dart';
import '../../../core/values/api_url_constant.dart';

class CreateQuizTestApi extends BaseRemoteSource {
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

  Future<Test> createTest({
    required String title,
    String? note,
    required List<Candidate> candidates,
  }) async {
    final request = dioClient.post(ApiUrlConstants.createTest, data: {
      "title": title,
      "note": note,
      "candidates": candidates.map((e) => e.toJson()).toList(),
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => Test.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }
}
