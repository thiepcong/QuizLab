import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/result_test_repository.dart';
import 'result_test_state.dart';

class ResultTestCubit extends Cubit<ResultTestState> {
  ResultTestCubit(this._repo) : super(const ResultTestState());

  final ResultTestRepository _repo;

  void getAllResult(int candidateID) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.getAllResult(candidateID: candidateID);
      emit(state.copyWith(results: res, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }
}
