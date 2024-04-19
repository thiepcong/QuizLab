import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/app/core/values/show_message_internal.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../main_router.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../repository/home_repository.dart';
import '../widgets/quiz_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Trang chủ',
      child: BlocProvider(
        create: (_) => HomeCubit(context.read<HomeRepository>())..init(),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeCubit, HomeState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.message != null) {
              ShowMessageInternal.showOverlay(context, state.message!);
            }
          },
        ),
        BlocListener<HomeCubit, HomeState>(
          listenWhen: (previous, current) =>
              previous.testFromCode != current.testFromCode,
          listener: (context, state) {
            if (state.testFromCode != null) {
              context.pushRoute(PlayTestViewRoute(test: state.testFromCode!));
            }
          },
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return Scaffold(
            appBar: CustomAppBar(
              label: 'Trang chủ',
              actions: [
                TextButton(
                  onPressed: () =>
                      context.pushRoute(const CreateQuizViewRoute()),
                  child: const Row(
                    children: [
                      Icon(Icons.add_circle_outline),
                      Text(
                        "Tạo một bài quiz",
                        style: TextStyles.mediumWhiteS14,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.router.pushAndPopUntil(
                      const LoginViewRoute(),
                      predicate: (_) => false,
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.logout),
                      Text(
                        "Đăng xuất",
                        style: TextStyles.mediumWhiteS14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  opacity: 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    state.quizes.isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: TextFormField(
                                  controller: _controller,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.length != 6) {
                                      return "Vui lòng nhập đúng 6 ký tự";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Nhập mã tham gia',
                                      suffixIcon: TextButton(
                                        onPressed: () => cubit
                                            .getTestFromCode(_controller.text),
                                        child: const Text("Tham gia"),
                                      ),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide())),
                                ),
                              ),
                              ...state.quizes.map(
                                (e) => QuizItem(
                                  item: e,
                                  onStart: () => context
                                      .pushRoute(CreateTestViewRoute(item: e)),
                                  onSave: () => cubit.saveExcel(e),
                                  onDelete: () => cubit.deleteQuiz(e),
                                  onEdit: () => context
                                      .pushRoute(EditQuizViewRoute(item: e)),
                                ),
                              )
                            ],
                          )
                        : Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                controller: _controller,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                validator: (value) {
                                  if (value == null || value.length != 6) {
                                    return "Vui lòng nhập đúng 6 ký tự";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Nhập mã tham gia',
                                    suffixIcon: TextButton(
                                      onPressed: () => cubit
                                          .getTestFromCode(_controller.text),
                                      child: const Text("Tham gia"),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide())),
                              ),
                            ),
                          ),
                    state.isLoading
                        ? Container(
                            color: AppColors.colorFF000000.withOpacity(0.5),
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
