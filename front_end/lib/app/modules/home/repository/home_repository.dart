import '../../../core/models/quiz.dart';
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
}
