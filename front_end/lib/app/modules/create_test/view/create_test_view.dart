import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/quiz.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/show_message_internal.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../core/widgets/button/primary_button.dart';
import '../cubit/create_test_cubit.dart';
import '../cubit/create_test_state.dart';
import '../repository/create_test_repository.dart';
import '../widgets/create_test_text_field.dart';
import '../widgets/no_candidate_widget.dart';

class CreateTestView extends StatefulWidget {
  const CreateTestView({super.key, this.item});

  final Quiz? item;

  @override
  State<CreateTestView> createState() => _CreateTestViewState();
}

class _CreateTestViewState extends State<CreateTestView> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: "Tạo bài kiểm tra mới",
      color: AppColors.colorFFFFFFFF,
      child: BlocProvider(
        create: (_) => CreateTestCubit(context.read<CreateTestRepository>()),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocListener<CreateTestCubit, CreateTestState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.message != null) {
          ShowMessageInternal.showOverlay(context, state.message!);
        }
      },
      child: BlocBuilder<CreateTestCubit, CreateTestState>(
        builder: (context, state) {
          final cubit = context.read<CreateTestCubit>();
          return Scaffold(
            appBar: CustomAppBar(
              isBack: true,
              label: 'Tạo một bài kiểm tra mới',
              actions: [
                if (state.createDone)
                  PrimaryButton(
                    width: 100,
                    onTap: () {
                      //
                    },
                    title: "Kết thúc",
                    backgroundColor: AppColors.colorFFB20000,
                    textColor: AppColors.colorFFFFFFFF,
                    borderColor: AppColors.colorFFB20000,
                    textSize: 16,
                  ),
              ],
            ),
            backgroundColor: AppColors.colorFFC5C5C5,
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
                    margin: const EdgeInsets.all(24),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: state.createDone
                        ? null
                        : BoxDecoration(
                            color: AppColors.colorFF000000.withOpacity(0.3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
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
                                PrimaryButton(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  onTap: () {
                                    //
                                  },
                                  title: "Bắt đầu",
                                  backgroundColor: AppColors.colorFF8854c0,
                                  textColor: AppColors.colorFFFFFFFF,
                                  borderColor: AppColors.colorFF8854c0,
                                  textSize: 28,
                                ),
                              ],
                            ),
                          )
                        : Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CreateTestTextField(
                                    controller: _titleController,
                                    labelText: "Nhập tiêu đề bài kiểm tra",
                                  ),
                                  CreateTestTextField(
                                    controller: _noteController,
                                    labelText: "Ghi chú",
                                  ),
                                  PrimaryButton(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    onTap: () {
                                      if (state.candidates.isEmpty) {
                                        ShowMessageInternal.showOverlay(context,
                                            "Vui lòng thêm ít nhất một người");
                                        return;
                                      }
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        cubit.createTest(
                                          widget.item?.id ?? 1,
                                          _titleController.text,
                                          _noteController.text,
                                        );
                                      }
                                    },
                                    title: "Tạo bài kiểm tra mới",
                                    backgroundColor: AppColors.colorFF8854c0,
                                    textColor: AppColors.colorFFFFFFFF,
                                    borderColor: AppColors.colorFF8854c0,
                                    textSize: 28,
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: AppColors.colorFFFFFFFF
                                          .withOpacity(0.6),
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
                                                onPickedFile: (picked) => cubit
                                                    .chooseCandidateFromExcel(
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
      ),
    );
  }
}
