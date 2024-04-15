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
    final accessToken = pre.getInt("id");
    var customHeaders = {
      'content-type': 'application/json',
      'Accept': "application/json"
    };
    if (accessToken != null) {
      customHeaders.addAll({
        'Authorization': "Bearer $accessToken",
      });
    }

    return customHeaders;
  }
}
