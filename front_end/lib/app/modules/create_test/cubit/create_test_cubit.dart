import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/create_test_repository.dart';
import 'create_test_state.dart';

class CreateTestCubit extends Cubit<CreateTestState> {
  CreateTestCubit(this._repo) : super(const CreateTestState());

  final CreateTestRepository _repo;

  void createTest(int quizId, String title, String? note) async {
    try {
      final pre = await SharedPreferences.getInstance();
      await pre.setInt("quizId", quizId);
      emit(state.copyWith(message: null, isLoading: true, createDone: false));
      final res = await _repo.createTest(
        title: title,
        note: note,
      );
      await pre.remove("quizId");
      emit(state.copyWith(
          isLoading: false, codeQuiz: res.quizCode, createDone: true));
    } catch (e) {
      final pre = await SharedPreferences.getInstance();
      await pre.remove("quizId");
      emit(state.copyWith(message: "Đã có lỗi xảy ra", isLoading: false));
      rethrow;
    }
  }
}
