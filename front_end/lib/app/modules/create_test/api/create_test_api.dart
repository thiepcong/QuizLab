import 'package:uuid/uuid.dart';

import '../../../core/base/base_remote_source.dart';
import '../../../core/values/api_url_constant.dart';

class CreateTestApi extends BaseRemoteSource {
  Future<String> createTest({
    required int quizId,
    required String title,
    String? note,
  }) async {
    String uuid = const Uuid().v4();
    String shortUuid = uuid.substring(0, 6);
    final request = dioClient.post(ApiUrlConstants.createTest, data: {
      "title": title,
      "timeCreated": DateTime.now().toString(),
      "quizCode": shortUuid,
      "note": note,
      "quiz": {"id": quizId},
      "candidates": [],
    });
    try {
      return callApiWithErrorParser(request).then((value) => shortUuid);
    } catch (e) {
      rethrow;
    }
  }
}
