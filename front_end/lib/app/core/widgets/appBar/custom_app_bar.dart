import 'package:flutter/material.dart';

import '../../values/app_colors.dart';
import '../../values/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.bgColor = AppColors.colorFF2F394B,
    required this.label,
    this.style,
    this.actions,
    this.isLeading = true,
  });

  final Color bgColor;
  final String label;
  final TextStyle? style;
  final List<Widget>? actions;
  final bool isLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isLeading
          ? Center(
              child: Text(
                "QUIZZ",
                style: TextStyles.boldWhiteS20
                    .copyWith(color: AppColors.colorFF9BD7FF, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          : null,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: bgColor,
      title: Text(
        label,
        style: style ?? TextStyles.boldWhiteS20,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
