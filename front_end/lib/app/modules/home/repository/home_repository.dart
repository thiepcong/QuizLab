import '../../../core/models/quiz.dart';
import '../../../core/models/test.dart';
import '../api/home_api.dart';

class HomeRepository {
  final HomeApi _api;

  HomeRepository(this._api);

  Future<List<Quiz>> getAllQuizByUser() async {
    return _api.getAllQuizByUser();
  }

  Future<void> deleteQuiz(int quizId) async {
    return _api.deleteQuiz(quizId);
  }

  Future<Test> getTestFromCode({required String code}) async {
    return _api.getTestFromCode(code: code);
  }
}
