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
    EditQuizViewRoute.name: (routeData) {
      final args = routeData.argsAs<EditQuizViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: EditQuizView(
          key: args.key,
          item: args.item,
        ),
      );
    },
    EditCreateQuestionViewRoute.name: (routeData) {
      final args = routeData.argsAs<EditCreateQuestionViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: EditCreateQuestionView(
          key: args.key,
          cubit: args.cubit,
        ),
      );
    },
    EditEditQuestionViewRoute.name: (routeData) {
      final args = routeData.argsAs<EditEditQuestionViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: EditEditQuestionView(
          key: args.key,
          cubit: args.cubit,
          item: args.item,
          index: args.index,
        ),
      );
    },
    CreateTestViewRoute.name: (routeData) {
      final args = routeData.argsAs<CreateTestViewRouteArgs>(
          orElse: () => const CreateTestViewRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CreateTestView(
          key: args.key,
          item: args.item,
        ),
      );
    },
    PlayTestViewRoute.name: (routeData) {
      final args = routeData.argsAs<PlayTestViewRouteArgs>(
          orElse: () => const PlayTestViewRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PlayTestView(
          key: args.key,
          test: args.test,
        ),
      );
    },
    PlayTestPageRoute.name: (routeData) {
      final args = routeData.argsAs<PlayTestPageRouteArgs>(
          orElse: () => const PlayTestPageRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PlayTestPage(
          key: args.key,
          test: args.test,
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
        RouteConfig(
          EditQuestionViewRoute.name,
          path: 'edit_question',
        ),
        RouteConfig(
          RegisterViewRoute.name,
          path: 'register',
        ),
        RouteConfig(
          EditQuizViewRoute.name,
          path: 'edit_quiz',
        ),
        RouteConfig(
          EditCreateQuestionViewRoute.name,
          path: 'edit_create_question',
        ),
        RouteConfig(
          EditEditQuestionViewRoute.name,
          path: 'edit_edit_question',
        ),
        RouteConfig(
          CreateTestViewRoute.name,
          path: 'create_test',
        ),
        RouteConfig(
          PlayTestViewRoute.name,
          path: 'play_test',
        ),
        RouteConfig(
          PlayTestPageRoute.name,
          path: 'play_test_page',
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

/// generated route for
/// [EditQuizView]
class EditQuizViewRoute extends PageRouteInfo<EditQuizViewRouteArgs> {
  EditQuizViewRoute({
    Key? key,
    required Quiz item,
  }) : super(
          EditQuizViewRoute.name,
          path: 'edit_quiz',
          args: EditQuizViewRouteArgs(
            key: key,
            item: item,
          ),
        );

  static const String name = 'EditQuizViewRoute';
}

class EditQuizViewRouteArgs {
  const EditQuizViewRouteArgs({
    this.key,
    required this.item,
  });

  final Key? key;

  final Quiz item;

  @override
  String toString() {
    return 'EditQuizViewRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [EditCreateQuestionView]
class EditCreateQuestionViewRoute
    extends PageRouteInfo<EditCreateQuestionViewRouteArgs> {
  EditCreateQuestionViewRoute({
    Key? key,
    required EditQuizCubit cubit,
  }) : super(
          EditCreateQuestionViewRoute.name,
          path: 'edit_create_question',
          args: EditCreateQuestionViewRouteArgs(
            key: key,
            cubit: cubit,
          ),
        );

  static const String name = 'EditCreateQuestionViewRoute';
}

class EditCreateQuestionViewRouteArgs {
  const EditCreateQuestionViewRouteArgs({
    this.key,
    required this.cubit,
  });

  final Key? key;

  final EditQuizCubit cubit;

  @override
  String toString() {
    return 'EditCreateQuestionViewRouteArgs{key: $key, cubit: $cubit}';
  }
}

/// generated route for
/// [EditEditQuestionView]
class EditEditQuestionViewRoute
    extends PageRouteInfo<EditEditQuestionViewRouteArgs> {
  EditEditQuestionViewRoute({
    Key? key,
    required EditQuizCubit cubit,
    required Question item,
    required int index,
  }) : super(
          EditEditQuestionViewRoute.name,
          path: 'edit_edit_question',
          args: EditEditQuestionViewRouteArgs(
            key: key,
            cubit: cubit,
            item: item,
            index: index,
          ),
        );

  static const String name = 'EditEditQuestionViewRoute';
}

class EditEditQuestionViewRouteArgs {
  const EditEditQuestionViewRouteArgs({
    this.key,
    required this.cubit,
    required this.item,
    required this.index,
  });

  final Key? key;

  final EditQuizCubit cubit;

  final Question item;

  final int index;

  @override
  String toString() {
    return 'EditEditQuestionViewRouteArgs{key: $key, cubit: $cubit, item: $item, index: $index}';
  }
}

/// generated route for
/// [CreateTestView]
class CreateTestViewRoute extends PageRouteInfo<CreateTestViewRouteArgs> {
  CreateTestViewRoute({
    Key? key,
    Quiz? item,
  }) : super(
          CreateTestViewRoute.name,
          path: 'create_test',
          args: CreateTestViewRouteArgs(
            key: key,
            item: item,
          ),
        );

  static const String name = 'CreateTestViewRoute';
}

class CreateTestViewRouteArgs {
  const CreateTestViewRouteArgs({
    this.key,
    this.item,
  });

  final Key? key;

  final Quiz? item;

  @override
  String toString() {
    return 'CreateTestViewRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [PlayTestView]
class PlayTestViewRoute extends PageRouteInfo<PlayTestViewRouteArgs> {
  PlayTestViewRoute({
    Key? key,
    Test? test,
  }) : super(
          PlayTestViewRoute.name,
          path: 'play_test',
          args: PlayTestViewRouteArgs(
            key: key,
            test: test,
          ),
        );

  static const String name = 'PlayTestViewRoute';
}

class PlayTestViewRouteArgs {
  const PlayTestViewRouteArgs({
    this.key,
    this.test,
  });

  final Key? key;

  final Test? test;

  @override
  String toString() {
    return 'PlayTestViewRouteArgs{key: $key, test: $test}';
  }
}

/// generated route for
/// [PlayTestPage]
class PlayTestPageRoute extends PageRouteInfo<PlayTestPageRouteArgs> {
  PlayTestPageRoute({
    Key? key,
    Test? test,
  }) : super(
          PlayTestPageRoute.name,
          path: 'play_test_page',
          args: PlayTestPageRouteArgs(
            key: key,
            test: test,
          ),
        );

  static const String name = 'PlayTestPageRoute';
}

class PlayTestPageRouteArgs {
  const PlayTestPageRouteArgs({
    this.key,
    this.test,
  });

  final Key? key;

  final Test? test;

  @override
  String toString() {
    return 'PlayTestPageRouteArgs{key: $key, test: $test}';
  }
}
