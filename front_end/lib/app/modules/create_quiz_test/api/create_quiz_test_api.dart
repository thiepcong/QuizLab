import '../../../core/base/base_remote_source.dart';
import '../../../core/models/candidate.dart';
import '../../../core/models/question.dart';
import '../../../core/models/test.dart';
import '../../../core/values/api_url_constant.dart';

class CreateQuizTestApi extends BaseRemoteSource {
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
    final request = dioClient.post(ApiUrlConstants.createTestCommon, data: {
      "title": titleQuiz,
      "timeStart": timeStart.toIso8601String(),
      "timeEnd": timeEnd.toIso8601String(),
      "note": note,
      "quiz": {
        "subject": subject,
        "title": titleTest,
        "time": time,
        "questions": questions.map((e) => e.toJson()).toList(),
      },
      "candidates": candidates.map((e) => e.toJson2()).toList(),
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => Test.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<Test> createTestFromExcel({
    required String quizTitle,
    required String subject,
    required String testTitle,
    String? testNote,
    required int time,
  }) async {
    final request = dioClient.post(
      ApiUrlConstants.createTestFromExcelCommon,
      data: {
        "quizTitle": quizTitle,
        "testNote": testNote,
        "subject": subject,
        "testTitle": testTitle,
        "time": time
      },
    );
    try {
      return callApiWithErrorParser(request)
          .then((value) => Test.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }
}
