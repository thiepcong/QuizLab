import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../cubit/create_quiz_cubit.dart';

class CreateQuestionView extends StatefulWidget {
  const CreateQuestionView({super.key, required this.cubit});

  final CreateQuizCubit cubit;

  @override
  State<CreateQuestionView> createState() => _CreateQuestionViewState();
}

class _CreateQuestionViewState extends State<CreateQuestionView> {
  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Tạo Câu hỏi',
      child: BlocProvider.value(
        value: widget.cubit,
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: 'Tạo câu hỏi',
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
    );
  }
}
