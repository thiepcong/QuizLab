import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../main_router.dart';
import '../cubit/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Trang chủ',
      child: BlocProvider(
        create: (_) => HomeCubit(),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: 'Trang chủ',
        actions: [
          TextButton(
            onPressed: () => context.pushRoute(const CreateQuizViewRoute()),
            child: const Row(
              children: [
                Icon(Icons.add_circle_outline),
                Text(
                  "Tạo một bài quiz",
                  style: TextStyles.mediumWhiteS14,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              context.router.pushAndPopUntil(
                const LoginViewRoute(),
                predicate: (_) => false,
              );
            },
            child: const Row(
              children: [
                Icon(Icons.logout),
                Text(
                  "Đăng xuất",
                  style: TextStyles.mediumWhiteS14,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: _controller,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(8),
              ],
              decoration: InputDecoration(
                  hintText: 'Nhập mã tham gia',
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: const Text("Tham gia"),
                  ),
                  border: const OutlineInputBorder(borderSide: BorderSide())),
            ),
          ),
        ),
      ),
    );
  }
}
