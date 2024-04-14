import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/app/main_router.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../core/widgets/button/custom_button.dart';
import '../cubit/create_quiz_cubit.dart';
import '../cubit/create_quiz_state.dart';

class CreateQuizView extends StatelessWidget {
  const CreateQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Tạo Quizz',
      child: BlocProvider(
        create: (_) => CreateQuizCubit(),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocBuilder<CreateQuizCubit, CreateQuizState>(
      builder: (context, state) {
        final cubit = context.read<CreateQuizCubit>();
        return Scaffold(
          appBar: CustomAppBar(
            label: 'Tạo một bài quiz mới',
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
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
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: const BoxDecoration(
                color: AppColors.colorFFFFFFFF,
                borderRadius: BorderRadius.all(Radius.circular(18)),
                boxShadow: [
                  BoxShadow(),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tạo một bài quiz mới",
                    style: TextStyles.boldBlackS20,
                  ),
                  const Text(
                    "Thêm một câu hỏi mới",
                    style: TextStyles.mediumBlackkS14,
                  ),
                  CustomButton(
                    width: MediaQuery.of(context).size.width * 0.2,
                    onTap: () => context
                        .pushRoute(CreateQuestionViewRoute(cubit: cubit)),
                    icon: Icons.done,
                    label: 'Nhiều lựa chọn',
                  ),
                  const Text(
                    "Nhập câu hỏi",
                    style: TextStyles.mediumBlackkS14,
                  ),
                  CustomButton(
                    width: MediaQuery.of(context).size.width * 0.2,
                    onTap: () async {
                      var picked = await FilePicker.platform.pickFiles(
                        allowedExtensions: ['xlsx'],
                        type: FileType.custom,
                      );

                      if (picked != null) {
                        log(picked.files.first.bytes.toString());
                      }
                    },
                    icon: Icons.slideshow,
                    label: 'Bảng tính',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
