import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_quiz_state.freezed.dart';

@freezed
class CreateQuizState with _$CreateQuizState {
  const CreateQuizState._();

  const factory CreateQuizState({
    @Default(false) bool isLoading,
    String? message,
    Error? error,
  }) = _CreateQuizState;
}
