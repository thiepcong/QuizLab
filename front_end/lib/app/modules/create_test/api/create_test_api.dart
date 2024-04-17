import '../../../core/base/base_remote_source.dart';
import '../../../core/models/test.dart';
import '../../../core/values/api_url_constant.dart';

class CreateTestApi extends BaseRemoteSource {
  Future<Test> createTest({
    required String title,
    String? note,
  }) async {
    final request = dioClient.post(ApiUrlConstants.createTest, data: {
      "title": title,
      "note": note,
      "candidates": [],
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => Test.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }
}
