import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/show_message_internal.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../core/widgets/button/custom_button.dart';
import '../../../main_router.dart';
import '../../create_quiz/widgets/quizz_item.dart';
import '../../create_quiz/widgets/title_text_field.dart';
import '../../create_test/widgets/no_candidate_widget.dart';
import '../cubit/create_quiz_test_cubit.dart';
import '../cubit/create_quiz_test_state.dart';
import '../repository/create_quiz_test_repository.dart';

class CreateQuizTestView extends StatefulWidget {
  const CreateQuizTestView({super.key});

  @override
  State<CreateQuizTestView> createState() => _CreateQuizTestViewState();
}

class _CreateQuizTestViewState extends State<CreateQuizTestView> {
  final _subjectController = TextEditingController();
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _titleTestController = TextEditingController();
  final _noteController = TextEditingController();
  final _timeStartController = TextEditingController();
  final _timeEndController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _titleController.dispose();
    _timeController.dispose();
    _titleTestController.dispose();
    _noteController.dispose();
    _timeEndController.dispose();
    _timeStartController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      if (!mounted) return;
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(pickedDate),
      );

      if (pickedTime != null) {
        _timeStartController.text = _formatDateTime(DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        ));
      }
    }
  }

  Future<void> _selectDateTimeEnd(BuildContext context) async {
    if (_timeStartController.text.isEmpty) {
      ShowMessageInternal.showOverlay(
          context, "Vui lòng chọn thời gian bắt đầu trước");
      return;
    }
    final pickedDate = await showDatePicker(
      context: context,
      initialDate:
          DateFormat('HH:mm dd-MM-yyyy').parse(_timeStartController.text),
      firstDate:
          DateFormat('HH:mm dd-MM-yyyy').parse(_timeStartController.text),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      if (!mounted) return;
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(pickedDate),
      );

      if (pickedTime != null) {
        _timeEndController.text = _formatDateTime(DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        ));
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm dd-MM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Tạo Quiz và Test',
      child: BlocProvider(
        create: (_) =>
            CreateQuizTestCubit(context.read<CreateQuizTestRepository>()),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateQuizTestCubit, CreateQuizTestState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.message != null) {
              ShowMessageInternal.showOverlay(context, state.message!);
            }
          },
        ),
      ],
      child: BlocBuilder<CreateQuizTestCubit, CreateQuizTestState>(
        builder: (context, state) {
          final cubit = context.read<CreateQuizTestCubit>();
          return Scaffold(
            appBar: CustomAppBar(
              isBack: true,
              onBackTap: () {
                context.router.pushAndPopUntil(
                  const HomeViewRoute(),
                  predicate: (_) => false,
                );
              },
              label: 'Tạo một bài quiz và test mới',
              actions: [
                if (state.codeQuiz == null)
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        cubit.createQuizAndTest(
                          _subjectController.text,
                          _timeController.text,
                          int.parse(_timeController.text),
                          _titleTestController.text,
                          _noteController.text,
                          _timeStartController.text,
                          _timeEndController.text,
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
                  child: state.createDone
                      ? Container(
                          decoration: BoxDecoration(
                            color: AppColors.colorFF000000.withOpacity(0.7),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Mã tham gia: ",
                                    style: TextStyles.regularWhiteS16,
                                  ),
                                  Text(
                                    state.codeQuiz ?? '',
                                    style: TextStyles.boldWhiteS28.copyWith(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
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
                                                onDelete: () => cubit
                                                    .deleteQuestion(e.value),
                                                onEdit: () => context.pushRoute(
                                                  EditQuizTestQuestionViewRoute(
                                                    cubit: cubit,
                                                    item: e.value,
                                                    index: e.key,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        state.questions.isEmpty
                                            ? const SizedBox.shrink()
                                            : TextButton(
                                                onPressed: () => context.pushRoute(
                                                    CreateQuizTestQuestionViewRoute(
                                                        cubit: cubit)),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.add),
                                                    Text(
                                                      "Thêm câu hỏi",
                                                      style: TextStyles
                                                          .regularBlackS14,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Thêm một câu hỏi mới",
                                          style: TextStyles.mediumBlackkS14,
                                        ),
                                        CustomButton(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          onTap: () => context.pushRoute(
                                              CreateQuizTestQuestionViewRoute(
                                                  cubit: cubit)),
                                          icon: Icons.done,
                                          label: 'Nhiều lựa chọn',
                                        ),
                                        const Text(
                                          "Nhập câu hỏi",
                                          style: TextStyles.mediumBlackkS14,
                                        ),
                                        CustomButton(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          onTap: () async {
                                            var picked = await FilePicker
                                                .platform
                                                .pickFiles(
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
                              const SizedBox(height: 24),
                              TitleTextField(
                                controller: _titleTestController,
                                labelText: "Nhập tiêu đề bài kiểm tra",
                              ),
                              TitleTextField(
                                controller: _noteController,
                                labelText: "Ghi chú",
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.colorFF000000),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                                child: TextFormField(
                                  controller: _timeStartController,
                                  validator: (val) => val!.trim().isEmpty
                                      ? "Trường bắt buộc"
                                      : null,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 1,
                                  readOnly: true,
                                  style: TextStyles.mediumWhiteS16
                                      .copyWith(color: AppColors.colorFF000000),
                                  cursorColor: AppColors.colorFF000000,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            _selectDateTime(context),
                                        icon: const Icon(
                                          Icons.calendar_month,
                                          color: AppColors.colorFF000000,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      labelText: "Thời gian bắt đầu",
                                      labelStyle:
                                          TextStyles.mediumWhiteS16.copyWith(
                                        color: AppColors.colorFF000000
                                            .withOpacity(0.3),
                                      )),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.colorFF000000),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                                child: TextFormField(
                                  controller: _timeEndController,
                                  validator: (val) => val!.trim().isEmpty
                                      ? "Trường bắt buộc"
                                      : null,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 1,
                                  readOnly: true,
                                  style: TextStyles.mediumWhiteS16
                                      .copyWith(color: AppColors.colorFF000000),
                                  cursorColor: AppColors.colorFF000000,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          _selectDateTimeEnd(context),
                                      icon: const Icon(
                                        Icons.calendar_month,
                                        color: AppColors.colorFF000000,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    labelText: "Thời gian kết thúc",
                                    labelStyle:
                                        TextStyles.mediumWhiteS16.copyWith(
                                      color: AppColors.colorFF000000
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.colorFFFFFFFF.withOpacity(0.6),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Danh sách người tham gia",
                                      style: TextStyles.mediumBlackS20,
                                    ),
                                    state.candidates.isEmpty
                                        ? NoCandidateWidget(
                                            onPickedFile: (picked) =>
                                                cubit.chooseCandidateFromExcel(
                                              picked.files.first.bytes,
                                              picked.files.first.name,
                                            ),
                                            onAddCandidate: (e) =>
                                                cubit.addCandidate(e),
                                          )
                                        : const SizedBox.shrink(),
                                    ...state.candidates
                                        .map((e) => Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const SizedBox(width: 40),
                                                  Text(e.name),
                                                  IconButton(
                                                    onPressed: () => cubit
                                                        .deleteCandidate(e),
                                                    icon: const Icon(
                                                        Icons.delete),
                                                  )
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                    state.candidates.isNotEmpty
                                        ? TextButton(
                                            onPressed: () =>
                                                showDialogAddCandidate(
                                              context,
                                              onAddCandidate: (e) =>
                                                  cubit.addCandidate(e),
                                            ),
                                            child: const Text("Thêm"),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
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
