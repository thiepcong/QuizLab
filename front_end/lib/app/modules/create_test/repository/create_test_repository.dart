import '../../../core/models/test.dart';
import '../api/create_test_api.dart';

class CreateTestRepository {
  final CreateTestApi _api;

  CreateTestRepository(this._api);

  Future<Test> createTest({
    required String title,
    String? note,
  }) async {
    return _api.createTest(
      title: title,
      note: note,
    );
  }
}
