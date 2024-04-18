import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/quiz.dart';
import '../repository/home_repository.dart';
import 'home_state.dart';
import 'dart:html' as html;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo) : super(const HomeState());

  final HomeRepository _repo;

  void init() {
    getAllQuizByUser();
  }

  void getAllQuizByUser() async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.getAllQuizByUser();
      emit(state.copyWith(isLoading: false, quizes: res));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }

  void saveExcel(Quiz item) {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      List<List<CellValue?>> data = item.questions
          .map((e) => [
                TextCellValue(e.content),
                ...e.answers.map((i) => TextCellValue(i.content)),
                ...e.answers.map((i) => TextCellValue(i.status.toString())),
              ])
          .toList();

      final excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      for (var row in data) {
        sheetObject.appendRow(row);
      }
      Uint8List excelData = Uint8List.fromList(excel.encode()!);
      final blob = html.Blob([excelData]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download", "${item.subject}.xlsx")
        ..click();
      html.Url.revokeObjectUrl(url);
      emit(state.copyWith(
        isLoading: false,
        message: "Tải xuống thành công",
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }

  void deleteQuiz(Quiz item) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      await _repo.deleteQuiz(item.id);
      List<Quiz> li = List.from(state.quizes);
      li.remove(item);
      emit(state.copyWith(
        isLoading: false,
        message: "Xoá thành công",
        quizes: li,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }

  void getTestFromCode(String code) async {
    try {
      emit(state.copyWith(isLoading: true, message: null, testFromCode: null));
      final res = await _repo.getTestFromCode(code: code);
      emit(state.copyWith(
        isLoading: false,
        message: "Đã thành công",
        testFromCode: res,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }
}
