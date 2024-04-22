import 'package:flutter/material.dart';

import '../../../core/models/question.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({
    super.key,
    required this.item,
    required this.index,
    required this.isCorrect,
    required this.choosen,
  });

  final Question item;
  final List<String> choosen;
  final int index;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: AppColors.colorFFFFFFFF,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: Border(
          left: BorderSide(
            width: 8,
            color:
                isCorrect ? AppColors.colorFF3CC03C : AppColors.colorFFB20000,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$index.  ${item.content}",
            style: TextStyles.regularBlackS16,
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
          ),
          const Divider(color: AppColors.colorFFEEECEC),
          ...item.answers
              .map(
                (e) => Row(
                  children: [
                    !e.status
                        ? const CircleAvatar(
                            radius: 8,
                            backgroundColor: AppColors.colorFFEEECEC,
                          )
                        : const CircleAvatar(
                            radius: 8,
                            backgroundColor: AppColors.colorFF72F672,
                            child: Icon(
                              Icons.done,
                              size: 12,
                            ),
                          ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        e.content +
                            (choosen.contains(e.content) ? "(Bạn chọn)" : ""),
                        style: TextStyles.regularBlackS16,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                      ),
                    ),
                  ],
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
