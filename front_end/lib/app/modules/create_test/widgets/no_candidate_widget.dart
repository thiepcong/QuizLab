import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/button/custom_button.dart';
import '../../../core/widgets/button/primary_button.dart';

class NoCandidateWidget extends StatelessWidget {
  const NoCandidateWidget({
    super.key,
    required this.onPickedFile,
    this.onAddCandidate,
  });

  final Function(FilePickerResult picked) onPickedFile;
  final void Function(String)? onAddCandidate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Chưa có người tham gia! "),
            TextButton(
              onPressed: () => showDialogAddCandidate(
                context,
                onAddCandidate: onAddCandidate,
              ),
              child: const Text("Thêm ngay"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomButton(
          width: MediaQuery.of(context).size.width * 0.3,
          onTap: () async {
            var picked = await FilePicker.platform.pickFiles(
              allowedExtensions: ['xlsx'],
              type: FileType.custom,
              allowMultiple: false,
            );

            if (picked != null) {
              onPickedFile.call(picked);
            }
          },
          icon: Icons.slideshow,
          label: 'Chọn từ bảng tính',
        ),
      ],
    );
  }
}

void showDialogAddCandidate(BuildContext context,
    {void Function(String)? onAddCandidate}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: AddCandidatePopup(
          onAddCandidate: onAddCandidate,
        ),
      );
    },
  );
}

class AddCandidatePopup extends StatefulWidget {
  const AddCandidatePopup({super.key, this.onAddCandidate});

  final void Function(String)? onAddCandidate;

  @override
  State<AddCandidatePopup> createState() => _AddCandidatePopupState();
}

class _AddCandidatePopupState extends State<AddCandidatePopup> {
  final _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: AppColors.colorFFFFFFFF,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Nhập người tham gia mới",
              style: TextStyles.boldBlackS20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: _controller,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Trường bắt buộc";
                  }
                  return null;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const SizedBox(width: 55),
                Expanded(
                  child: PrimaryButton(
                    title: 'Quay lại',
                    backgroundColor: AppColors.colorFFFFFFFF,
                    textColor: AppColors.colorFF000000,
                    textSize: 16,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 55),
                Expanded(
                  child: PrimaryButton(
                    title: 'Lưu',
                    backgroundColor: AppColors.colorFFFFFFFF,
                    textColor: AppColors.colorFF000000,
                    textSize: 16,
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        widget.onAddCandidate?.call(_controller.text);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 55),
              ],
            )
          ],
        ),
      ),
    );
  }
}
