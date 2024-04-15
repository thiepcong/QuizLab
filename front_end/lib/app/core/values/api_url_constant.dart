import '../../network/dio_provider.dart';

final baseUrl = DioProvider.baseUrl;

class ApiUrlConstants {
  static String register = '$baseUrl/api/user/save';

  static String login = '$baseUrl/api/user/login';
}
