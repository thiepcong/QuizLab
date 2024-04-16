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
    EditQuestionViewRoute.name: (routeData) {
      final args = routeData.argsAs<EditQuestionViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: EditQuestionView(
          key: args.key,
          cubit: args.cubit,
          item: args.item,
          index: args.index,
        ),
      );
    },
    RegisterViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RegisterView(),
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
        RouteConfig(
          EditQuestionViewRoute.name,
          path: 'edit_question',
        ),
        RouteConfig(
          RegisterViewRoute.name,
          path: 'register',
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

/// generated route for
/// [EditQuestionView]
class EditQuestionViewRoute extends PageRouteInfo<EditQuestionViewRouteArgs> {
  EditQuestionViewRoute({
    Key? key,
    required CreateQuizCubit cubit,
    required Question item,
    required int index,
  }) : super(
          EditQuestionViewRoute.name,
          path: 'edit_question',
          args: EditQuestionViewRouteArgs(
            key: key,
            cubit: cubit,
            item: item,
            index: index,
          ),
        );

  static const String name = 'EditQuestionViewRoute';
}

class EditQuestionViewRouteArgs {
  const EditQuestionViewRouteArgs({
    this.key,
    required this.cubit,
    required this.item,
    required this.index,
  });

  final Key? key;

  final CreateQuizCubit cubit;

  final Question item;

  final int index;

  @override
  String toString() {
    return 'EditQuestionViewRouteArgs{key: $key, cubit: $cubit, item: $item, index: $index}';
  }
}

/// generated route for
/// [RegisterView]
class RegisterViewRoute extends PageRouteInfo<void> {
  const RegisterViewRoute()
      : super(
          RegisterViewRoute.name,
          path: 'register',
        );

  static const String name = 'RegisterViewRoute';
}
