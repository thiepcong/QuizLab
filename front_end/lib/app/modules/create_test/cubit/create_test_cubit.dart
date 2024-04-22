import 'dart:developer';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/candidate.dart';
import '../repository/create_test_repository.dart';
import 'create_test_state.dart';

class CreateTestCubit extends Cubit<CreateTestState> {
  CreateTestCubit(this._repo) : super(const CreateTestState());

  final CreateTestRepository _repo;

  void createTest(
    int quizId,
    String title,
    String? note,
    String timeStart,
    String timeEnd,
  ) async {
    try {
      if (state.filePath != null) {
        createTestFromExcel(quizId, title, note, timeStart, timeEnd);
        return;
      }
      final pre = await SharedPreferences.getInstance();
      await pre.setInt("quizId", quizId);
      await pre.setString("timeStart", timeStart);
      await pre.setString("timeEnd", timeEnd);
      emit(state.copyWith(message: null, isLoading: true, createDone: false));
      final res = await _repo.createTest(
        title: title,
        note: note,
        candidates: state.candidates,
      );
      await pre.remove("quizId");
      await pre.remove("timeStart");
      await pre.remove("timeEnd");
      emit(state.copyWith(
          isLoading: false, codeQuiz: res.quizCode, createDone: true));
    } catch (e) {
      final pre = await SharedPreferences.getInstance();
      await pre.remove("quizId");
      await pre.remove("timeStart");
      await pre.remove("timeEnd");
      emit(state.copyWith(message: "Đã có lỗi xảy ra", isLoading: false));
      rethrow;
    }
  }

  void createTestFromExcel(
    int quizId,
    String title,
    String? note,
    String timeStart,
    String timeEnd,
  ) async {
    try {
      if (state.filePath == null) return;
      final pre = await SharedPreferences.getInstance();
      await pre.setInt("quizId", quizId);
      await pre.setString('filePath', state.filePath!);
      await pre.setString("timeStart", timeStart);
      await pre.setString("timeEnd", timeEnd);
      emit(state.copyWith(message: null, isLoading: true, createDone: false));
      final res = await _repo.createTestFromExcel(
        title: title,
        note: note,
      );
      await pre.remove("quizId");
      await pre.remove('filePath');
      await pre.remove("timeStart");
      await pre.remove("timeEnd");
      emit(state.copyWith(
          isLoading: false, codeQuiz: res.quizCode, createDone: true));
    } catch (e) {
      final pre = await SharedPreferences.getInstance();
      await pre.remove("quizId");
      await pre.remove('filePath');
      await pre.remove("timeStart");
      await pre.remove("timeEnd");
      emit(state.copyWith(message: "Đã có lỗi xảy ra", isLoading: false));
      rethrow;
    }
  }

  void chooseCandidateFromExcel(Uint8List? bytes, String fileName) {
    if (bytes == null) return;
    try {
      emit(state.copyWith(message: null, isLoading: true));
      var excel = Excel.decodeBytes(bytes);
      List<Candidate> li = [];
      for (final table in excel.tables.keys) {
        log(table);
        for (final row in excel.tables[table]!.rows) {
          li.add(Candidate(name: row[0]!.value.toString()));
        }
      }
      emit(state.copyWith(
        candidates: li,
        isLoading: false,
        filePath: "C:/Users/Admin/Downloads/$fileName",
      ));
    } catch (e) {
      emit(state.copyWith(message: "Vui lòng thử lại", isLoading: false));
      rethrow;
    }
  }

  void addCandidate(String e) {
    List<Candidate> li = List.from(state.candidates);
    li.add(Candidate(name: e));
    emit(state.copyWith(candidates: li, filePath: null));
  }

  void deleteCandidate(Candidate e) {
    List<Candidate> li = List.from(state.candidates);
    li.remove(e);
    emit(state.copyWith(candidates: li, filePath: null));
  }
}
