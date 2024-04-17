import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'app_routes.dart';
import 'core/models/question.dart';
import 'core/models/quiz.dart';
import 'modules/create_quiz/cubit/create_quiz_cubit.dart';
import 'modules/create_quiz/view/create_question_view.dart';
import 'modules/create_quiz/view/create_quiz_view.dart';
import 'modules/create_quiz/view/edit_question_view.dart';
import 'modules/create_test/view/create_test_view.dart';
import 'modules/edit_quiz/cubit/edit_quiz_cubit.dart';
import 'modules/edit_quiz/view/edit_create_question_view.dart';
import 'modules/edit_quiz/view/edit_edit_question_view.dart';
import 'modules/edit_quiz/view/edit_quiz_view.dart';
import 'modules/home/view/home_view.dart';
import 'modules/login/view/login_view.dart';
import 'modules/login/view/register_view.dart';
part 'main_router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: LoginView, path: Routes.login, initial: true),
    MaterialRoute(page: HomeView, path: Routes.home),
    MaterialRoute(page: CreateQuizView, path: Routes.createQuiz),
    MaterialRoute(page: CreateQuestionView, path: Routes.createQuestion),
    MaterialRoute(page: EditQuestionView, path: Routes.editQuestion),
    MaterialRoute(page: RegisterView, path: Routes.register),
    MaterialRoute(page: EditQuizView, path: Routes.editQuiz),
    MaterialRoute(
        page: EditCreateQuestionView, path: Routes.editCreateQuestion),
    MaterialRoute(page: EditEditQuestionView, path: Routes.editEditQuestion),
    MaterialRoute(page: CreateTestView, path: Routes.createTest),
  ],
)
class MainRouter extends _$MainRouter {
  MainRouter({
    GlobalKey<NavigatorState>? navigatorKey,
  }) : super(navigatorKey);
}
