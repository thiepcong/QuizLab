abstract class Routes {
  const Routes._();
  static const login = _Paths.login;

  static const register = _Paths.register;

  static const home = _Paths.home;

  static const createQuiz = _Paths.createQuiz;

  static const createQuestion = _Paths.createQuestion;

  static const editQuestion = _Paths.editQuestion;

  static const editQuiz = _Paths.editQuiz;

  static const editCreateQuestion = _Paths.editCreateQuestion;

  static const editEditQuestion = _Paths.editEditQuestion;

  static const createTest = _Paths.createTest;

  static const playTest = _Paths.playTest;

  static const playTestPage = _Paths.playTestPage;
}

abstract class _Paths {
  static const login = 'login';

  static const register = 'register';

  static const home = 'home';

  static const createQuiz = 'create_quiz';

  static const createQuestion = 'create_question';

  static const editQuestion = 'edit_question';

  static const editQuiz = 'edit_quiz';

  static const editCreateQuestion = 'edit_create_question';

  static const editEditQuestion = 'edit_edit_question';

  static const createTest = 'create_test';

  static const playTest = 'play_test';

  static const playTestPage = 'play_test_page';
}
