import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'service_task_progress_state.dart';

class ServiceTaskProgressCubit extends Cubit<ServiceTaskProgressState> {
  ServiceTaskProgressCubit() : super(const ServiceTaskProgressState());

  late WebSocketChannel channel;

  void init() {
    final wsUrl = Uri.parse('ws://localhost:8887/ws/websocket');

    channel = WebSocketChannel.connect(wsUrl);

    channel.stream.listen((event) {
      try {
        List<String> res = List.from(state.progress);
        res.add(event.toString());
        emit(state.copyWith(progress: res));
      } catch (e) {
        if (state is StateError) return;
        rethrow;
      }
    });
  }

  void start() {
    channel.sink.add("Start");
  }

  void dispose() {
    channel.sink.close();
  }
}
