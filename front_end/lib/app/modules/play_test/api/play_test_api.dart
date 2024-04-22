import '../../../core/base/base_remote_source.dart';
import '../../../core/models/candidate.dart';
import '../../../core/values/api_url_constant.dart';

class PlayTestApi extends BaseRemoteSource {
  Future<Candidate> createCandidate({required Candidate cadidate}) async {
    final request = dioClient.post(
      ApiUrlConstants.createCandidate,
      data: cadidate.toJson(),
    );
    try {
      return callApiWithErrorParser(request)
          .then((value) => Candidate.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }
}
