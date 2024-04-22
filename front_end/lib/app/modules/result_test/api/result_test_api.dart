import '../../../core/base/base_remote_source.dart';
import '../../../core/models/result.dart';
import '../../../core/values/api_url_constant.dart';

class ResultTestApi extends BaseRemoteSource {
  Future<List<Result>> getAllResult({required int candidateID}) async {
    final request = dioClient.get(ApiUrlConstants.getAllResult(candidateID));
    try {
      return callApiWithErrorParser(request).then((value) =>
          (value.data as List).map((e) => Result.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }
}
