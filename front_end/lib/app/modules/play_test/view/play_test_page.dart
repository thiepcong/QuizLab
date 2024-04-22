import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:front_end/app/core/values/show_message_internal.dart';
import 'package:front_end/app/main_router.dart';

import '../../../core/models/test.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../cubit/play_test_cubit.dart';
import '../cubit/play_test_state.dart';
import '../widgets/answer_field.dart';
import '../widgets/bottom_edit.dart';

class PlayTestPage extends StatefulWidget {
  const PlayTestPage({
    super.key,
    required this.test,
    required this.cubit,
  });

  final Test test;
  final PlayTestCubit cubit;

  @override
  State<PlayTestPage> createState() => _PlayTestPageState();
}

class _PlayTestPageState extends State<PlayTestPage> {
  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: "Chơi thôi!",
      child: BlocProvider.value(
        value: widget.cubit..initPlayTest(widget.test),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PlayTestCubit, PlayTestState>(
          listenWhen: (previous, current) =>
              previous.isPLayDone != current.isPLayDone,
          listener: (context, state) {
            if (state.isPLayDone) {
              context.read<PlayTestCubit>().createCandidate();
            }
          },
        ),
        BlocListener<PlayTestCubit, PlayTestState>(
          listenWhen: (previous, current) =>
              previous.candidate != current.candidate,
          listener: (context, state) {
            if (state.candidate != null) {
              context.pushRoute(ResultTestViewRoute(
                item: widget.test,
                candidateId: state.candidate?.id ?? -1,
              ));
            }
          },
        ),
        BlocListener<PlayTestCubit, PlayTestState>(
          listenWhen: (previous, current) =>
              previous.secondCountdown != current.secondCountdown,
          listener: (context, state) {
            if (state.secondCountdown == 0) {
              context.read<PlayTestCubit>().endTime();
            }
          },
        ),
        BlocListener<PlayTestCubit, PlayTestState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.message != null) {
              ShowMessageInternal.showOverlay(context, state.message ?? '');
            }
          },
        ),
      ],
      child: BlocBuilder<PlayTestCubit, PlayTestState>(
        builder: (context, state) {
          final cubit = context.read<PlayTestCubit>();
          return Scaffold(
            appBar: const CustomAppBar(
              label: 'Chơi thôi!',
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
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.colorFF461a42,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      boxShadow: [
                        BoxShadow(),
                      ],
                    ),
                    child: state.currentQuestion == null
                        ? Container(
                            color: AppColors.colorFF000000.withOpacity(0.5),
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.colorFFFFFFFF),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                  ),
                                  child: Text(
                                    state.currentQuestion!.content,
                                    style: TextStyles.regularWhiteS20
                                        .copyWith(fontSize: 28),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    AnswerField(
                                      isMultipleChoice: state.isMultipleChoice,
                                      index: "A",
                                      label: state
                                          .currentQuestion!.answers[0].content,
                                      color: state.isTrueA
                                          ? AppColors.colorFF3CC03C
                                          : state.isFalse
                                              ? AppColors.colorFF9A0F0F
                                              : AppColors.colorFF2d70ae,
                                      isCheck: state.isChooseA,
                                      onChanged: (e) =>
                                          cubit.setCheckBoxAnswer('A', e),
                                      onTap: () => cubit.chooseAnswer('A'),
                                      opacity: (state.isChooseA ||
                                              state.isTrueA ||
                                              (!state.isChooseA &&
                                                  !state.isChooseB &&
                                                  !state.isChooseC &&
                                                  !state.isChooseD))
                                          ? 1
                                          : 0,
                                    ),
                                    AnswerField(
                                      isMultipleChoice: state.isMultipleChoice,
                                      index: "B",
                                      label: state
                                          .currentQuestion!.answers[1].content,
                                      color: state.isTrueB
                                          ? AppColors.colorFF3CC03C
                                          : state.isFalse
                                              ? AppColors.colorFF9A0F0F
                                              : AppColors.colorFF2d9da6,
                                      isCheck: state.isChooseB,
                                      onChanged: (e) =>
                                          cubit.setCheckBoxAnswer('B', e),
                                      onTap: () => cubit.chooseAnswer('B'),
                                      opacity: (state.isChooseB ||
                                              state.isTrueB ||
                                              (!state.isChooseA &&
                                                  !state.isChooseB &&
                                                  !state.isChooseC &&
                                                  !state.isChooseD))
                                          ? 1
                                          : 0,
                                    ),
                                    AnswerField(
                                      isMultipleChoice: state.isMultipleChoice,
                                      index: "C",
                                      label: state
                                          .currentQuestion!.answers[2].content,
                                      color: state.isTrueC
                                          ? AppColors.colorFF3CC03C
                                          : state.isFalse
                                              ? AppColors.colorFF9A0F0F
                                              : AppColors.colorFFefa929,
                                      isCheck: state.isChooseC,
                                      onChanged: (e) =>
                                          cubit.setCheckBoxAnswer('C', e),
                                      onTap: () => cubit.chooseAnswer('C'),
                                      opacity: (state.isChooseC ||
                                              state.isTrueC ||
                                              (!state.isChooseA &&
                                                  !state.isChooseB &&
                                                  !state.isChooseC &&
                                                  !state.isChooseD))
                                          ? 1
                                          : 0,
                                    ),
                                    AnswerField(
                                      isMultipleChoice: state.isMultipleChoice,
                                      index: "D",
                                      label: state
                                          .currentQuestion!.answers[3].content,
                                      color: state.isTrueD
                                          ? AppColors.colorFF3CC03C
                                          : state.isFalse
                                              ? AppColors.colorFF9A0F0F
                                              : AppColors.colorFFd5546d,
                                      isCheck: state.isChooseD,
                                      onChanged: (e) =>
                                          cubit.setCheckBoxAnswer('D', e),
                                      onTap: () => cubit.chooseAnswer('D'),
                                      opacity: (state.isChooseD ||
                                              state.isTrueD ||
                                              (!state.isChooseA &&
                                                  !state.isChooseB &&
                                                  !state.isChooseC &&
                                                  !state.isChooseD))
                                          ? 1
                                          : 0,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                  ),
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: AppColors.colorFFFFFFFF.withOpacity(0.8),
                      ),
                      child: Text(
                        "${state.currentIndexQuestion + 1}/${state.questions.length}",
                        style: TextStyles.boldBlackS20,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.colorFFFFFFFF.withOpacity(0.8),
                          ),
                          child: Text(
                            "${state.secondCountdown}",
                            style: TextStyles.boldBlackS20,
                          ),
                        ),
                        Positioned.fill(
                          child: SpinKitDualRing(
                            color: AppColors.colorFF8854c0,
                            size: state.secondCountdown > 9 ? 56 : 44,
                            duration: const Duration(seconds: 1),
                          ),
                        ),
                      ],
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
            bottomNavigationBar: BottomEdit(
              canTap: state.isMultipleChoice &&
                  (state.isChooseA ||
                      state.isChooseB ||
                      state.isChooseC ||
                      state.isChooseD),
              onNext: () => cubit.handleNext(),
            ),
          );
        },
      ),
    );
  }
}
