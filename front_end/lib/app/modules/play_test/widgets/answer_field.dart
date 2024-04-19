import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class AnswerField extends StatelessWidget {
  const AnswerField({
    super.key,
    this.color,
    required this.isCheck,
    this.onChanged,
    required this.label,
    this.onTap,
    required this.index,
    this.opacity = 1,
    required this.isMultipleChoice,
  });

  final bool isMultipleChoice;
  final double opacity;
  final Color? color;
  final bool isCheck;
  final void Function(bool?)? onChanged;
  final String label;
  final String index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Opacity(
        opacity: isMultipleChoice ? 1 : opacity,
        child: InkWell(
          onTap: () {
            if (isMultipleChoice) {
              onChanged?.call(!isCheck);
              return;
            }
            if (opacity == 1) {
              onTap?.call();
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      index,
                      style: TextStyles.boldWhiteS20,
                    ),
                    isMultipleChoice
                        ? Checkbox(value: isCheck, onChanged: onChanged)
                        : const SizedBox.shrink()
                  ],
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    // height: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.colorFFFFFFFF),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      label,
                      style: TextStyles.regularWhiteS18,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                    ),
                  ),
                ),
              ],
            ),
            // Column(
            //   children: [
            //     // Container(
            //     //   width: double.infinity,
            //     //   alignment: Alignment.centerRight,
            //     //   // child: Checkbox(value: isCheck, onChanged: onChanged),
            //     // ),

            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
