import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/create_test_repository.dart';
import 'create_test_state.dart';

class CreateTestCubit extends Cubit<CreateTestState> {
  CreateTestCubit(this._repo) : super(const CreateTestState());

  final CreateTestRepository _repo;

  void createTest(int quizId, String title, String? note) async {
    try {
      emit(state.copyWith(message: null, isLoading: true, createDone: false));
      final res = await _repo.createTest(
        quizId: quizId,
        title: title,
        note: note,
      );
      emit(state.copyWith(isLoading: false, codeQuiz: res, createDone: true));
    } catch (e) {
      emit(state.copyWith(message: "Đã có lỗi xảy ra", isLoading: false));
      rethrow;
    }
  }
}
