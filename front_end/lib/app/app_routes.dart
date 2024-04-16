abstract class Routes {
  const Routes._();
  static const login = _Paths.login;

  static const register = _Paths.register;

  static const home = _Paths.home;

  static const createQuiz = _Paths.createQuiz;

  static const createQuestion = _Paths.createQuestion;

  static const editQuestion = _Paths.editQuestion;
}

abstract class _Paths {
  static const login = 'login';

  static const register = 'register';

  static const home = 'home';

  static const createQuiz = 'create_quiz';

  static const createQuestion = 'create_question';

  static const editQuestion = 'edit_question';
}
