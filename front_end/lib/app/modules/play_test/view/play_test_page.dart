import 'package:flutter/material.dart';

import '../../../core/models/test.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../widgets/answer_field.dart';

class PlayTestPage extends StatefulWidget {
  const PlayTestPage({super.key, this.test});

  final Test? test;

  @override
  State<PlayTestPage> createState() => _PlayTestPageState();
}

class _PlayTestPageState extends State<PlayTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        label: 'Chơi thôi!',
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            opacity: 0.2,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: const BoxDecoration(
            color: AppColors.colorFF461a42,
            borderRadius: BorderRadius.all(Radius.circular(18)),
            boxShadow: [
              BoxShadow(),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.colorFFFFFFFF),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: const Text(
                    "question",
                    style: TextStyles.regularWhiteS20,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    AnswerField(
                      index: "A",
                      label: "oke",
                      color: AppColors.colorFF2d70ae,
                      isCheck: true,
                      onChanged: (e) {},
                      onTap: () {},
                    ),
                    AnswerField(
                      index: "B",
                      label: "oke",
                      color: AppColors.colorFF2d9da6,
                      isCheck: false,
                      onChanged: (e) {},
                      onTap: () {},
                    ),
                    AnswerField(
                      index: "C",
                      label: "oke",
                      color: AppColors.colorFFefa929,
                      isCheck: false,
                      onChanged: (e) {},
                      onTap: () {},
                    ),
                    AnswerField(
                      index: "D",
                      label: "oke",
                      color: AppColors.colorFFd5546d,
                      isCheck: false,
                      onChanged: (e) {},
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
