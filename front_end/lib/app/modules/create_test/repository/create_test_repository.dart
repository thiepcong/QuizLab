import '../api/create_test_api.dart';

class CreateTestRepository {
  final CreateTestApi _api;

  CreateTestRepository(this._api);

  Future<String> createTest({
    required int quizId,
    required String title,
    String? note,
  }) async {
    return _api.createTest(
      quizId: quizId,
      title: title,
      note: note,
    );
  }
}
