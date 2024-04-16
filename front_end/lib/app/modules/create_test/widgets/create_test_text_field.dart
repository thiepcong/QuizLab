import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class CreateTestTextField extends StatelessWidget {
  const CreateTestTextField({
    super.key,
    this.controller,
    this.inputFormatters = const [],
    this.labelText,
  });

  final TextEditingController? controller;
  final List<TextInputFormatter> inputFormatters;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.colorFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: TextFormField(
        controller: controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(20),
          ...inputFormatters,
        ],
        validator: (val) => val!.trim().isEmpty ? "Trường bắt buộc" : null,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 1,
        style: TextStyles.mediumWhiteS16,
        cursorColor: AppColors.colorFFFFFFFF,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            labelText: labelText,
            labelStyle: TextStyles.mediumWhiteS16.copyWith(
              color: AppColors.colorFFFFFFFF.withOpacity(0.3),
            )),
      ),
    );
  }
}
