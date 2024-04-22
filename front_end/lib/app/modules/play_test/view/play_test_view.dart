import 'dart:async';

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
  const PlayTestView({super.key, required this.test});

  final Test test;

  @override
  State<PlayTestView> createState() => _PlayTestViewState();
}

class _PlayTestViewState extends State<PlayTestView> {
  String? _handleDuration(DateTime start, DateTime end) {
    if (start.isAfter(DateTime.now())) {
      Duration duration = start.difference(DateTime.now());
      String days = duration.inDays.toString();
      String hours = (duration.inHours % 24).toString();
      String minutes = (duration.inMinutes % 60).toString();
      String seconds = (duration.inSeconds % 60).toString();

      return 'Vui lòng chờ \n Còn $days ngày $hours giờ $minutes phút $seconds giây';
    } else if (DateTime.now().isAfter(end)) {
      return "Bài kiểm tra đã hết hạn";
    }
    return null;
  }

  String? res;
  Timer? timer;

  void init() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        res = _handleDuration(widget.test.timeStart, widget.test.timeEnd);
      });
      if (res == null || res == "Bài kiểm tra đã hết hạn") {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    res = null;
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: "Chuẩn bị",
      child: BlocProvider(
        create: (_) => PlayTestCubit(),
        child: _buildPage(context),
      ),
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
                  context.router.push(PlayTestPageRoute(
                    test: widget.test,
                    cubit: cubit,
                  ));
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
              child: res != null
                  ? Text(
                      res ?? '',
                      style: TextStyles.boldWhiteS28
                          .copyWith(color: AppColors.colorFF000000),
                      textAlign: TextAlign.center,
                    )
                  : SingleChildScrollView(
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
                          ...widget.test.candidates
                              .map((e) => CandidateChooseItem(
                                    groupValue: state.chooseCandidate?.name,
                                    value: e.name,
                                    onChanged: (e) => cubit.setChooseCandidate(
                                        e, widget.test.candidates),
                                  ))
                              .toList(),
                          // CandidateChooseItem(
                          //   groupValue: state.chooseCandidate,
                          //   value: 'name2',
                          //   onChanged: (e) => cubit.setChooseCandidate(e),
                          // ),
                          // CandidateChooseItem(
                          //   groupValue: state.chooseCandidate,
                          //   value: 'name3',
                          //   onChanged: (e) => cubit.setChooseCandidate(e),
                          // ),
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
