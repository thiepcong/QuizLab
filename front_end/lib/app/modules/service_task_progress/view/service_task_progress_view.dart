import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../cubit/service_task_progress_cubit.dart';
import '../cubit/service_task_progress_state.dart';

class ServiceTaskProgressView extends StatefulWidget {
  const ServiceTaskProgressView({super.key});

  @override
  State<ServiceTaskProgressView> createState() =>
      _ServiceTaskProgressViewState();
}

class _ServiceTaskProgressViewState extends State<ServiceTaskProgressView> {
  ServiceTaskProgressCubit? originCubit;

  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'WebSocket Task Service Progress',
      child: BlocProvider(
        create: (_) => ServiceTaskProgressCubit()..init(),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocBuilder<ServiceTaskProgressCubit, ServiceTaskProgressState>(
      builder: (context, state) {
        final cubit = context.read<ServiceTaskProgressCubit>();
        originCubit ??= cubit;
        return Scaffold(
          appBar: const CustomAppBar(
            isBack: true,
            label: 'WebSocket Task Service Progress',
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
            child: state.progress.isEmpty
                ? Center(
                    child: TextButton(
                      onPressed: () {
                        cubit.start();
                      },
                      child: const Text(
                        "Start",
                        style: TextStyles.boldBlackS28,
                      ),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: state.progress.length,
                      itemBuilder: (context, index) {
                        return Text(
                          state.progress[index],
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    originCubit?.dispose();
    super.dispose();
  }
}
