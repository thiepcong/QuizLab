import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'service_task_progress_state.dart';

class ServiceTaskProgressCubit extends Cubit<ServiceTaskProgressState> {
  ServiceTaskProgressCubit() : super(const ServiceTaskProgressState());

  late WebSocketChannel channel;
  late WebSocketChannel channel2;
  late WebSocketChannel channel3;

  void init() {
    final wsUrl = Uri.parse('ws://localhost:8887/ws/websocket');
    final wsUrl2 = Uri.parse('ws://localhost:8888/ws/websocket');
    final wsUrl3 = Uri.parse('ws://localhost:8889/ws/websocket');

    channel = WebSocketChannel.connect(wsUrl);
    channel2 = WebSocketChannel.connect(wsUrl2);
    channel3 = WebSocketChannel.connect(wsUrl3);

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
    channel2.stream.listen((event) {
      try {
        List<String> res = List.from(state.progress);
        res.add(event.toString());
        emit(state.copyWith(progress: res));
      } catch (e) {
        if (state is StateError) return;
        rethrow;
      }
    });
    channel3.stream.listen((event) {
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
    channel2.sink.add("Start");
    channel3.sink.add("Start");
  }

  void dispose() {
    channel.sink.close();
    channel2.sink.close();
    channel3.sink.close();
  }
}
