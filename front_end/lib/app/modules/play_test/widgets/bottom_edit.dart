import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';

class BottomEdit extends StatelessWidget {
  const BottomEdit({
    super.key,
    required this.canTap,
    this.onNext,
  });

  final bool canTap;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.colorFF000000.withOpacity(0.8),
      ),
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () {
          if (canTap) {
            onNext?.call();
          }
        },
        icon: CircleAvatar(
          backgroundColor:
              canTap ? AppColors.colorFF8854c0 : AppColors.colorFFC5C5C5,
          child: const Icon(
            Icons.arrow_right,
            color: AppColors.colorFFFFFFFF,
          ),
        ),
      ),
    );
  }
}
