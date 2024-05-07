import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_task_progress_state.freezed.dart';

@freezed
class ServiceTaskProgressState with _$ServiceTaskProgressState {
  const ServiceTaskProgressState._();

  const factory ServiceTaskProgressState({
    @Default(false) bool isLoading,
    @Default([]) List<String> progress,
    String? message,
    Error? error,
  }) = _ServiceTaskProgressState;
}
