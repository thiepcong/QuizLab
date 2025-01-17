import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Map<String, String>> getCustomHeaders() async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getInt("userId");
    final filePath = pre.getString("filePath");
    final quizFilePath = pre.getString("quizFilePath");
    final testFilePath = pre.getString("testFilePath");
    final quizId = pre.getInt("quizId");
    final timeStart = pre.getString("timeStart");
    final timeEnd = pre.getString("timeEnd");
    var customHeaders = {
      'content-type': 'application/json',
      'Accept': "application/json"
    };
    if (userId != null) {
      customHeaders.addAll({
        'userId': "$userId",
      });
    }
    if (filePath != null) {
      customHeaders.addAll({
        'filePath': filePath,
      });
    }
    if (testFilePath != null) {
      customHeaders.addAll({
        'testFilePath': testFilePath,
      });
    }
    if (quizFilePath != null) {
      customHeaders.addAll({
        'quizFilePath': quizFilePath,
      });
    }
    if (quizId != null) {
      customHeaders.addAll({
        'quizId': quizId.toString(),
      });
    }
    if (timeStart != null) {
      customHeaders.addAll({
        'timeStart': timeStart,
      });
    }
    if (timeEnd != null) {
      customHeaders.addAll({
        'timeEnd': timeEnd,
      });
    }

    return customHeaders;
  }
}
