import '../../../core/base/base_remote_source.dart';
import '../../../core/models/candidate.dart';
import '../../../core/models/test.dart';
import '../../../core/values/api_url_constant.dart';

class CreateTestApi extends BaseRemoteSource {
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

  Future<Test> createTestFromExcel({
    required String title,
    String? note,
  }) async {
    final request = dioClient.post(ApiUrlConstants.createTestFromExcel, data: {
      "title": title,
      "note": note,
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => Test.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }
}
