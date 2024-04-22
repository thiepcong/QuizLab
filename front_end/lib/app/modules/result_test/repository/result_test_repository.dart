import '../../../core/models/result.dart';
import '../api/result_test_api.dart';

class ResultTestRepository {
  final ResultTestApi _api;

  ResultTestRepository(this._api);

  Future<List<Result>> getAllResult({required int candidateID}) async {
    return _api.getAllResult(candidateID: candidateID);
  }
}
