import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/result.dart';

part 'result_test_state.freezed.dart';

@freezed
class ResultTestState with _$ResultTestState {
  const ResultTestState._();

  const factory ResultTestState({
    @Default([]) List<Result> results,
    @Default(false) bool isLoading,
    String? message,
    Error? error,
  }) = _ResultTestState;
}
