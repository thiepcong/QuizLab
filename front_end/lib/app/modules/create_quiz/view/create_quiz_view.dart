import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/app/core/values/show_message_internal.dart';
import 'package:front_end/app/main_router.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../core/widgets/button/custom_button.dart';
import '../cubit/create_quiz_cubit.dart';
import '../cubit/create_quiz_state.dart';
import '../repository/create_quiz_repository.dart';
import '../widgets/quizz_item.dart';
import '../widgets/title_text_field.dart';

class CreateQuizView extends StatefulWidget {
  const CreateQuizView({super.key});

  @override
  State<CreateQuizView> createState() => _CreateQuizViewState();
}

class _CreateQuizViewState extends State<CreateQuizView> {
  final _subjectController = TextEditingController();
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      title: 'Tạo Quizz',
      child: BlocProvider(
        create: (_) => CreateQuizCubit(context.read<CreateQuizRepository>()),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateQuizCubit, CreateQuizState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.message != null) {
              ShowMessageInternal.showOverlay(context, state.message!);
            }
          },
        ),
        BlocListener<CreateQuizCubit, CreateQuizState>(
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
      child: BlocBuilder<CreateQuizCubit, CreateQuizState>(
        builder: (context, state) {
          final cubit = context.read<CreateQuizCubit>();
          return Scaffold(
            appBar: CustomAppBar(
              isBack: true,
              label: 'Tạo một bài quiz mới',
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      cubit.createQuiz(
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
                  height: double.infinity,
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
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg.jpg"),
                      opacity: 0.2,
                      fit: BoxFit.cover,
                    ),
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
                        if (state.isImportFile)
                          Row(
                            children: [
                              const Text(
                                  "Bạn muốn xuất bản luôn hay tiếp tục chỉnh sửa?"),
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    cubit.createQuizFromExcel(
                                        _subjectController.text,
                                        _titleController.text,
                                        int.parse(_timeController.text));
                                  }
                                },
                                child: const Text("Xuất bản ngay"),
                              ),
                              TextButton(
                                onPressed: () => context.pushRoute(
                                    CreateQuestionViewRoute(cubit: cubit)),
                                child: const Text("Thêm"),
                              )
                            ],
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
                                            EditQuestionViewRoute(
                                              cubit: cubit,
                                              item: e.value,
                                              index: e.key,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  state.isImportFile
                                      ? const SizedBox.shrink()
                                      : TextButton(
                                          onPressed: () => context.pushRoute(
                                              CreateQuestionViewRoute(
                                                  cubit: cubit)),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add),
                                              Text(
                                                "Thêm câu hỏi",
                                                style:
                                                    TextStyles.regularBlackS14,
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
                                        CreateQuestionViewRoute(cubit: cubit)),
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
