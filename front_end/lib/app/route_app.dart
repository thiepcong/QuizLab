import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/values/app_theme.dart';
import 'main_router.dart';
import 'modules/create_quiz/api/create_quiz_api.dart';
import 'modules/create_quiz/repository/create_quiz_repository.dart';
import 'modules/create_quiz_test/api/create_quiz_test_api.dart';
import 'modules/create_quiz_test/repository/create_quiz_test_repository.dart';
import 'modules/create_test/api/create_test_api.dart';
import 'modules/create_test/repository/create_test_repository.dart';
import 'modules/edit_quiz/api/edit_quiz_api.dart';
import 'modules/edit_quiz/repository/edit_quiz_repository.dart';
import 'modules/home/api/home_api.dart';
import 'modules/home/repository/home_repository.dart';
import 'modules/login/api/login_api.dart';
import 'modules/login/repository/login_repository.dart';
import 'modules/play_test/api/play_test_api.dart';
import 'modules/play_test/repository/play_test_repository.dart';
import 'modules/result_test/api/result_test_api.dart';
import 'modules/result_test/repository/result_test_repository.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class RouteApp extends StatefulWidget {
  const RouteApp({super.key});

  @override
  State<RouteApp> createState() => _RouteAppState();
}

class _RouteAppState extends State<RouteApp> {
  @override
  void initState() {
    super.initState();
    _appRouter = MainRouter(
      navigatorKey: navigatorKey,
    );
  }

  late MainRouter _appRouter;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LoginRepository>(
          create: (context) => LoginRepository(LoginApi()),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(HomeApi()),
        ),
        RepositoryProvider<CreateQuizRepository>(
          create: (context) => CreateQuizRepository(CreateQuizApi()),
        ),
        RepositoryProvider<EditQuizRepository>(
          create: (context) => EditQuizRepository(EditQuizApi()),
        ),
        RepositoryProvider<CreateTestRepository>(
          create: (context) => CreateTestRepository(CreateTestApi()),
        ),
        RepositoryProvider<PlayTestRepository>(
          create: (context) => PlayTestRepository(PlayTestApi()),
        ),
        RepositoryProvider<ResultTestRepository>(
          create: (context) => ResultTestRepository(ResultTestApi()),
        ),
        RepositoryProvider<CreateQuizTestRepository>(
          create: (context) => CreateQuizTestRepository(CreateQuizTestApi()),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(
          navigatorObservers: () => [
            AutoRouteObserver(),
          ],
        ),
        theme: appTheme,
        localizationsDelegates: const [],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
