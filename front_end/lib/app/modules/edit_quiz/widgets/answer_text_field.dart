import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class AnswerTextField extends StatelessWidget {
  const AnswerTextField({
    super.key,
    this.controller,
    this.color,
    required this.isCheck,
    this.onChanged,
  });

  final TextEditingController? controller;
  final Color? color;
  final bool isCheck;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: Checkbox(value: isCheck, onChanged: onChanged),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.colorFFFFFFFF),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: TextFormField(
                    controller: controller,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2000),
                    ],
                    validator: (val) =>
                        val!.trim().isEmpty ? "Trường bắt buộc" : null,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 6,
                    cursorColor: AppColors.colorFFFFFFFF,
                    textAlign: TextAlign.center,
                    style: TextStyles.regularWhiteS18,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
