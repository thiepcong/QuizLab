import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/app/core/values/show_message_internal.dart';

import '../../../core/models/test.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../main_router.dart';
import '../cubit/play_test_cubit.dart';
import '../cubit/play_test_state.dart';
import '../widgets/candidate_choose_item.dart';

class PlayTestView extends StatefulWidget {
  const PlayTestView({super.key, this.test});

  final Test? test;

  @override
  State<PlayTestView> createState() => _PlayTestViewState();
}

class _PlayTestViewState extends State<PlayTestView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayTestCubit(),
      child: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocBuilder<PlayTestCubit, PlayTestState>(
      builder: (context, state) {
        final cubit = context.read<PlayTestCubit>();
        return Scaffold(
          appBar: CustomAppBar(
            isBack: true,
            label: 'Chuẩn bị',
            actions: [
              TextButton(
                onPressed: () {
                  if (state.chooseCandidate == null) {
                    ShowMessageInternal.showOverlay(
                        context, "Vui lòng chọn một người để tham gia");
                    return;
                  }
                  context.router.replace(PlayTestPageRoute(test: widget.test));
                },
                child: const Row(
                  children: [
                    Icon(Icons.play_arrow),
                    Text(
                      "Bắt đầu chơi",
                      style: TextStyles.mediumWhiteS14,
                    ),
                  ],
                ),
              ),
            ],
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
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 48, horizontal: 80),
              decoration: BoxDecoration(
                color: AppColors.colorFFFFFFFF.withOpacity(0.6),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sắp xong rồi!",
                      style: TextStyles.boldBlackS20,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Vui lòng chọn để tham gia",
                      style: TextStyles.mediumBlackS20,
                    ),
                    const SizedBox(height: 24),
                    CandidateChooseItem(
                      groupValue: state.chooseCandidate,
                      value: 'name1',
                      onChanged: (e) => cubit.setChooseCandidate(e),
                    ),
                    CandidateChooseItem(
                      groupValue: state.chooseCandidate,
                      value: 'name2',
                      onChanged: (e) => cubit.setChooseCandidate(e),
                    ),
                    CandidateChooseItem(
                      groupValue: state.chooseCandidate,
                      value: 'name3',
                      onChanged: (e) => cubit.setChooseCandidate(e),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
