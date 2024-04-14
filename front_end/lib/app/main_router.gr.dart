// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'main_router.dart';

class _$MainRouter extends RootStackRouter {
  _$MainRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    CreateQuizViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CreateQuizView(),
      );
    },
    CreateQuestionViewRoute.name: (routeData) {
      final args = routeData.argsAs<CreateQuestionViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CreateQuestionView(
          key: args.key,
          cubit: args.cubit,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'login',
          fullMatch: true,
        ),
        RouteConfig(
          LoginViewRoute.name,
          path: 'login',
        ),
        RouteConfig(
          HomeViewRoute.name,
          path: 'home',
        ),
        RouteConfig(
          CreateQuizViewRoute.name,
          path: 'create_quiz',
        ),
        RouteConfig(
          CreateQuestionViewRoute.name,
          path: 'create_question',
        ),
      ];
}

/// generated route for
/// [LoginView]
class LoginViewRoute extends PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: 'login',
        );

  static const String name = 'LoginViewRoute';
}

/// generated route for
/// [HomeView]
class HomeViewRoute extends PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: 'home',
        );

  static const String name = 'HomeViewRoute';
}

/// generated route for
/// [CreateQuizView]
class CreateQuizViewRoute extends PageRouteInfo<void> {
  const CreateQuizViewRoute()
      : super(
          CreateQuizViewRoute.name,
          path: 'create_quiz',
        );

  static const String name = 'CreateQuizViewRoute';
}

/// generated route for
/// [CreateQuestionView]
class CreateQuestionViewRoute
    extends PageRouteInfo<CreateQuestionViewRouteArgs> {
  CreateQuestionViewRoute({
    Key? key,
    required CreateQuizCubit cubit,
  }) : super(
          CreateQuestionViewRoute.name,
          path: 'create_question',
          args: CreateQuestionViewRouteArgs(
            key: key,
            cubit: cubit,
          ),
        );

  static const String name = 'CreateQuestionViewRoute';
}

class CreateQuestionViewRouteArgs {
  const CreateQuestionViewRouteArgs({
    this.key,
    required this.cubit,
  });

  final Key? key;

  final CreateQuizCubit cubit;

  @override
  String toString() {
    return 'CreateQuestionViewRouteArgs{key: $key, cubit: $cubit}';
  }
}
