import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/app/core/values/show_message_internal.dart';

import '../../../core/models/question.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../create_quiz/widgets/answer_text_field.dart';
import '../cubit/create_quiz_test_cubit.dart';
import '../cubit/create_quiz_test_state.dart';

class EditQuizTestQuestionView extends StatefulWidget {
  const EditQuizTestQuestionView({
    super.key,
    required this.cubit,
    required this.item,
    required this.index,
  });

  final CreateQuizTestCubit cubit;
  final Question item;
  final int index;

  @override
  State<EditQuizTestQuestionView> createState() =>
      _EditQuizTestQuestionViewState();
}

class _EditQuizTestQuestionViewState extends State<EditQuizTestQuestionView> {
  final _questionController = TextEditingController();
  final _answerAController = TextEditingController();
  final _answerBController = TextEditingController();
  final _answerCController = TextEditingController();
  final _answerDController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _questionController.text = widget.item.content;
    _answerAController.text = widget.item.answers[0].content;
    _answerBController.text = widget.item.answers[1].content;
    _answerCController.text = widget.item.answers[2].content;
    _answerDController.text = widget.item.answers[3].content;
    super.initState();
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerAController.dispose();
    _answerBController.dispose();
    _answerCController.dispose();
    _answerDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Sửa Câu hỏi',
      child: BlocProvider.value(
        value: widget.cubit..initEdit(widget.item),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocListener<CreateQuizTestCubit, CreateQuizTestState>(
      listenWhen: (previous, current) =>
          previous.saveQuestionDone != current.saveQuestionDone,
      listener: (context, state) {
        if (state.saveQuestionDone) {
          context.router.pop();
        }
      },
      child: BlocBuilder<CreateQuizTestCubit, CreateQuizTestState>(
        builder: (context, state) {
          final cubit = context.read<CreateQuizTestCubit>();
          return Scaffold(
            appBar: CustomAppBar(
              isBack: true,
              label: 'Sửa câu hỏi',
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (state.rightAnswer.isEmpty) {
                        ShowMessageInternal.showOverlay(
                            context, "Vui lòng chọn ít nhất một đáp án đúng");
                        return;
                      }
                      cubit.editQuestion(
                        widget.index,
                        _questionController.text,
                        _answerAController.text,
                        _answerBController.text,
                        _answerCController.text,
                        _answerDController.text,
                      );
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.save),
                      Text(
                        "Lưu câu hỏi",
                        style: TextStyles.mediumWhiteS14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // backgroundColor: AppColors.colorFFC5C5C5,
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
              child: Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: const BoxDecoration(
                  color: AppColors.colorFF461a42,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  boxShadow: [
                    BoxShadow(),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorFFFFFFFF),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: TextFormField(
                            controller: _questionController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2000),
                            ],
                            validator: (val) =>
                                val!.trim().isEmpty ? "Trường bắt buộc" : null,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 9,
                            style: TextStyles.regularWhiteS20,
                            cursorColor: AppColors.colorFFFFFFFF,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            AnswerTextField(
                              controller: _answerAController,
                              color: AppColors.colorFF2d70ae,
                              isCheck: state.rightAnswer.contains('A'),
                              onChanged: (e) => cubit.setRightAnswer(e, 'A'),
                            ),
                            AnswerTextField(
                              controller: _answerBController,
                              color: AppColors.colorFF2d9da6,
                              isCheck: state.rightAnswer.contains('B'),
                              onChanged: (e) => cubit.setRightAnswer(e, 'B'),
                            ),
                            AnswerTextField(
                              controller: _answerCController,
                              color: AppColors.colorFFefa929,
                              isCheck: state.rightAnswer.contains('C'),
                              onChanged: (e) => cubit.setRightAnswer(e, 'C'),
                            ),
                            AnswerTextField(
                              controller: _answerDController,
                              color: AppColors.colorFFd5546d,
                              isCheck: state.rightAnswer.contains('D'),
                              onChanged: (e) => cubit.setRightAnswer(e, 'D'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
