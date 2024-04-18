import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/quiz.dart';
import '../../../core/models/test.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    @Default(false) bool isLoading,
    Test? testFromCode,
    @Default([]) List<Quiz> quizes,
    String? message,
    Error? error,
  }) = _HomeState;
}
