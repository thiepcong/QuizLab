import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/app/core/values/show_message_internal.dart';
import 'package:front_end/app/main_router.dart';

import '../../../core/models/quiz.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../core/widgets/button/custom_button.dart';
import '../cubit/edit_quiz_cubit.dart';
import '../cubit/edit_quiz_state.dart';
import '../repository/edit_quiz_repository.dart';
import '../widgets/quizz_item.dart';
import '../widgets/title_text_field.dart';

class EditQuizView extends StatefulWidget {
  const EditQuizView({super.key, required this.item});

  final Quiz item;

  @override
  State<EditQuizView> createState() => _EditQuizViewState();
}

class _EditQuizViewState extends State<EditQuizView> {
  final _subjectController = TextEditingController();
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _subjectController.text = widget.item.subject;
    _titleController.text = widget.item.title;
    _timeController.text = widget.item.time.toString();
    super.initState();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _titleController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Sửa Quizz',
      child: BlocProvider(
        create: (_) => EditQuizCubit(context.read<EditQuizRepository>())
          ..init(widget.item),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EditQuizCubit, EditQuizState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.message != null) {
              ShowMessageInternal.showOverlay(context, state.message!);
            }
          },
        ),
        BlocListener<EditQuizCubit, EditQuizState>(
          listenWhen: (previous, current) =>
              previous.saveQuizDone != current.saveQuizDone,
          listener: (context, state) {
            if (state.saveQuizDone) {
              context.router.pushAndPopUntil(
                const HomeViewRoute(),
                predicate: (_) => false,
              );
            }
          },
        ),
      ],
      child: BlocBuilder<EditQuizCubit, EditQuizState>(
        builder: (context, state) {
          final cubit = context.read<EditQuizCubit>();
          return Scaffold(
            appBar: CustomAppBar(
              isBack: true,
              label: 'Sửa bài quiz',
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      cubit.editQuiz(
                        _subjectController.text,
                        _timeController.text,
                        int.parse(_timeController.text),
                      );
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.save),
                      Text(
                        "Xuất bản",
                        style: TextStyles.mediumWhiteS14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.colorFFC5C5C5,
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: const BoxDecoration(
                    color: AppColors.colorFFFFFFFF,
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tạo một bài quiz mới",
                                style: TextStyles.boldBlackS20,
                              ),
                              TitleTextField(
                                controller: _subjectController,
                                labelText: "Nhập tên chủ đề",
                              ),
                              TitleTextField(
                                controller: _titleController,
                                labelText: "Tiêu đề",
                              ),
                              TitleTextField(
                                controller: _timeController,
                                labelText: "Thời gian mỗi câu hỏi (giây)",
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                              ),
                            ],
                          ),
                        ),
                        state.questions.isNotEmpty
                            ? Column(
                                children: [
                                  ...state.questions
                                      .asMap()
                                      .entries
                                      .map(
                                        (e) => QuizzItem(
                                          item: e.value,
                                          onDelete: () =>
                                              cubit.deleteQuestion(e.value),
                                          onEdit: () => context.pushRoute(
                                            EditEditQuestionViewRoute(
                                              cubit: cubit,
                                              item: e.value,
                                              index: e.key,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  TextButton(
                                    onPressed: () => context.pushRoute(
                                        EditCreateQuestionViewRoute(
                                            cubit: cubit)),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add),
                                        Text(
                                          "Thêm câu hỏi",
                                          style: TextStyles.regularBlackS14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Thêm một câu hỏi mới",
                                    style: TextStyles.mediumBlackkS14,
                                  ),
                                  CustomButton(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    onTap: () => context.pushRoute(
                                        EditCreateQuestionViewRoute(
                                            cubit: cubit)),
                                    icon: Icons.done,
                                    label: 'Nhiều lựa chọn',
                                  ),
                                  const Text(
                                    "Nhập câu hỏi",
                                    style: TextStyles.mediumBlackkS14,
                                  ),
                                  CustomButton(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    onTap: () async {
                                      var picked =
                                          await FilePicker.platform.pickFiles(
                                        allowedExtensions: ['xlsx'],
                                        type: FileType.custom,
                                        allowMultiple: false,
                                      );

                                      if (picked != null) {
                                        cubit.chooseFileExcel(
                                          picked.files.first.bytes,
                                          picked.files.first.name,
                                        );
                                      }
                                    },
                                    icon: Icons.slideshow,
                                    label: 'Bảng tính',
                                  ),
                                ],
                              ),
                      ],
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
          );
        },
      ),
    );
  }
}
