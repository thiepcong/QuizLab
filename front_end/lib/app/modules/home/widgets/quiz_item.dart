import 'package:flutter/material.dart';

import '../../../core/models/quiz.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/button/custom_button.dart';
import '../../../core/widgets/button/primary_button.dart';

class QuizItem extends StatelessWidget {
  const QuizItem({
    super.key,
    required this.item,
    this.onSave,
    this.onEdit,
    this.onDelete,
    this.onStart,
  });

  final Quiz item;
  final VoidCallback? onStart;
  final VoidCallback? onSave;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 120),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chủ đề: ${item.subject}",
                    style: TextStyles.mediumBlackS20,
                  ),
                  Text(
                    "Tiêu đề: ${item.title}",
                    style: TextStyles.mediumBlackS20
                        .copyWith(color: AppColors.colorFF2F394B),
                  ),
                  Text(
                    "Thời gian mỗi câu hỏi (giây): ${item.time}",
                    style: TextStyles.mediumBlackS14,
                  ),
                ],
              ),
              InkWell(
                onTap: () => onStart?.call(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 18,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    color: AppColors.colorFF8854c0,
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: AppColors.colorFFFFFFFF,
                      ),
                      Text(
                        "Bắt đầu ngay",
                        style: TextStyles.boldWhiteS20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                onTap: () => onSave?.call(),
                icon: Icons.save,
                label: "Tải xuống dạng bảng tính",
              ),
              const SizedBox(width: 8),
              CustomButton(
                onTap: () => onEdit?.call(),
                icon: Icons.edit_document,
                label: "Chỉnh sửa",
              ),
              const SizedBox(width: 8),
              CustomButton(
                onTap: () => _showDialogDelete(
                  context,
                  () => onDelete?.call(),
                ),
                icon: Icons.delete_forever,
                label: "Xoá",
              ),
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
