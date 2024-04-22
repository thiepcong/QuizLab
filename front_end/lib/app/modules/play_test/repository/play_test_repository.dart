import '../../../core/models/candidate.dart';
import '../api/play_test_api.dart';

class PlayTestRepository {
  final PlayTestApi _api;

  PlayTestRepository(this._api);

  Future<Candidate> createCandidate({required Candidate cadidate}) async {
    return _api.createCandidate(cadidate: cadidate);
  }
}
