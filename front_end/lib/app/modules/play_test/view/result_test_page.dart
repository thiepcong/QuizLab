import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end/app/main_router.dart';
import '../../../core/models/test.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../widgets/question_item.dart';

class ResultTestView extends StatefulWidget {
  const ResultTestView({super.key, required this.item, required this.right});

  final Test item;
  final int right;

  @override
  State<ResultTestView> createState() => _ResultTestViewState();
}

class _ResultTestViewState extends State<ResultTestView> {
  @override
  Widget build(BuildContext context) {
    return Title(
        color: AppColors.colorFFFFFFFF,
        title: 'Kết quả',
        child: _buildPage(context));
  }

  Widget _buildPage(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                decoration: const BoxDecoration(
                  color: AppColors.colorFF000000,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Câu đúng: ${widget.right}/${widget.item.quiz.questions.length}",
                      style: TextStyles.regularWhiteS16,
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: widget.right / widget.item.quiz.questions.length,
                      backgroundColor: AppColors.colorFFef3c69,
                      color: AppColors.colorFF72F672,
                      minHeight: 24,
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
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
                      ))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
