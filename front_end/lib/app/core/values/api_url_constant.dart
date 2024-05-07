import '../../network/dio_provider.dart';

final baseUrl = DioProvider.baseUrl;

class ApiUrlConstants {
  static String register = '$baseUrl:8080/api/user/save';

  static String login = '$baseUrl:8080/api/user/login';

  static String createQuizFromExcel =
      '$baseUrl:8083/api/quizzes/create-from-excel';

  static String createQuiz = '$baseUrl:8083/api/quizzes/add';

  static String editQuiz(int id) => '$baseUrl:8080/api/quizzes/$id';

  static String getAllQuizByUser = '$baseUrl:8080/api/quizzes/users';

  static String deleteQuiz(int id) => '$baseUrl:8080/api/quizzes/$id';

  static String createTest = '$baseUrl:8084/api/tests';

  static String createTestFromExcel =
      '$baseUrl:8084/api/tests/create-from-excel';

  static String getTestFromQuizCode(String quizCode) =>
      '$baseUrl:8080/api/tests/code/$quizCode';

  static String createCandidate = '$baseUrl:8080/api/candidates';

  static String getAllResult(int candidateID) =>
      '$baseUrl:9000/api/results/candidate/$candidateID';

  static String createTestCommon = '$baseUrl:8080/api/create-test';

  static String createTestFromExcelCommon =
      '$baseUrl:8080/api/create-test-from-excel';
}
