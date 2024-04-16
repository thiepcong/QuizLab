import '../../../core/base/base_remote_source.dart';
import '../../../core/models/quiz.dart';
import '../../../core/values/api_url_constant.dart';

class HomeApi extends BaseRemoteSource {
  Future<List<Quiz>> getAllQuizByUser() async {
    final request = dioClient.get(ApiUrlConstants.getAllQuizByUser);
    try {
      return callApiWithErrorParser(request).then((value) =>
          (value.data as List).map((e) => Quiz.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteQuiz(int quizId) async {
    final request = dioClient.delete(ApiUrlConstants.deleteQuiz(quizId));
    try {
      return callApiWithErrorParser(request).then((value) => true);
    } catch (e) {
      rethrow;
    }
  }
}
