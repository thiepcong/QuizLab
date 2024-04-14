import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'app_routes.dart';
import 'modules/create_quiz/cubit/create_quiz_cubit.dart';
import 'modules/create_quiz/view/create_question_view.dart';
import 'modules/create_quiz/view/create_quiz_view.dart';
import 'modules/home/view/home_view.dart';
import 'modules/login/view/login_view.dart';
part 'main_router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: LoginView, path: Routes.login, initial: true),
    MaterialRoute(page: HomeView, path: Routes.home),
    MaterialRoute(page: CreateQuizView, path: Routes.createQuiz),
    MaterialRoute(page: CreateQuestionView, path: Routes.createQuestion),
  ],
)
class MainRouter extends _$MainRouter {
  MainRouter({
    GlobalKey<NavigatorState>? navigatorKey,
  }) : super(navigatorKey);
}
