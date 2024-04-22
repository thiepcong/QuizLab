import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/app/main_router.dart';
import '../../../core/models/test.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../cubit/result_test_cubit.dart';
import '../cubit/result_test_state.dart';
import '../repository/result_test_repository.dart';
import '../widgets/question_item.dart';

class ResultTestView extends StatefulWidget {
  const ResultTestView({
    super.key,
    required this.item,
    required this.candidateId,
  });

  final Test item;
  final int candidateId;

  @override
  State<ResultTestView> createState() => _ResultTestViewState();
}

class _ResultTestViewState extends State<ResultTestView> {
  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Kết quả',
      child: BlocProvider(
        create: (_) => ResultTestCubit(context.read<ResultTestRepository>())
          ..getAllResult(widget.candidateId),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocBuilder<ResultTestCubit, ResultTestState>(
      builder: (context, state) {
        final numCorrect =
            state.results.where((element) => element.correct).length;
        return Scaffold(
          appBar: CustomAppBar(
            label: 'Kết quả',
            actions: [
              TextButton(
                onPressed: () {
                  context.router.pushAndPopUntil(
                    const HomeViewRoute(),
                    predicate: (_) => false,
                  );
                },
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.home),
                    Text(
                      "Về trang chủ",
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
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.colorFFFFFFFF,
              borderRadius: BorderRadius.all(Radius.circular(18)),
              boxShadow: [
                BoxShadow(),
              ],
              image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"),
                opacity: 0.2,
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: state.results.length ==
                            widget.item.quiz.questions.length
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 12),
                                decoration: const BoxDecoration(
                                  color: AppColors.colorFF000000,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Câu đúng: $numCorrect/${widget.item.quiz.questions.length}",
                                      style: TextStyles.regularWhiteS16,
                                    ),
                                    const SizedBox(height: 12),
                                    LinearProgressIndicator(
                                      value: numCorrect /
                                          widget.item.quiz.questions.length,
                                      backgroundColor: AppColors.colorFFef3c69,
                                      color: AppColors.colorFF72F672,
                                      minHeight: 24,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(24)),
                                    ),
                                  ],
                                ),
                              ),
                              ...widget.item.quiz.questions
                                  .asMap()
                                  .entries
                                  .map((e) => QuestionItem(
                                        item: e.value,
                                        index: e.key + 1,
                                        isCorrect: state.results[e.key].correct,
                                        choosen:
                                            state.results[e.key].chosenAnswers,
                                      ))
                                  .toList()
                            ],
                          )
                        : const SizedBox.shrink(),
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
        );
      },
    );
  }
}
