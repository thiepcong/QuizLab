import 'package:flutter/material.dart';

import '../../../core/models/answer.dart';
import '../../../core/models/question.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/button/primary_button.dart';

class QuizzItem extends StatelessWidget {
  const QuizzItem({
    super.key,
    required this.item,
    this.onEdit,
    this.onDelete,
  });

  final Question item;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.colorFFEEECEC),
        color: AppColors.colorFFFFFFFF,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => onEdit?.call(),
                child: const Row(
                  children: [
                    Icon(Icons.edit),
                    Text(
                      "Chỉnh sửa",
                      style: TextStyles.smallBlackS14,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => _showDialogDelete(
                  context,
                  () => onDelete?.call(),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.delete),
                    Text(
                      "Xoá",
                      style: TextStyles.smallBlackS14,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              item.content,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.regularBlackS16,
            ),
          ),
          Row(
            children: [
              AnswerQuizzItem(item: item.answers[0]),
              AnswerQuizzItem(item: item.answers[1]),
            ],
          ),
          Row(
            children: [
              AnswerQuizzItem(item: item.answers[2]),
              AnswerQuizzItem(item: item.answers[3]),
            ],
          ),
        ],
      ),
    );
  }

  void _showDialogDelete(BuildContext context, VoidCallback? onDelete) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Bạn chắc chắn muốn xoá?"),
          actions: [
            PrimaryButton(
              title: 'Quay lại',
              backgroundColor: AppColors.colorFFFFFFFF,
              textColor: AppColors.colorFF000000,
              textSize: 24,
              onTap: () => Navigator.pop(context),
            ),
            PrimaryButton(
              title: 'Xoá',
              backgroundColor: AppColors.colorFFFFFFFF,
              textColor: AppColors.colorFF000000,
              textSize: 24,
              onTap: () {
                Navigator.pop(context);
                onDelete?.call();
              },
            ),
          ],
        );
      },
    );
  }
}

class AnswerQuizzItem extends StatelessWidget {
  const AnswerQuizzItem({super.key, required this.item});

  final Answer item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          item.status
              ? const Icon(
                  Icons.done,
                  color: AppColors.colorFF0E8023,
                )
              : const Icon(
                  Icons.close,
                  color: AppColors.colorFFB20000,
                ),
          Expanded(
            child: Text(
              item.content,
              maxLines: null,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.regularBlackS14,
            ),
          ),
        ],
      ),
    );
  }
}
