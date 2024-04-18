import 'package:flutter/material.dart';

class CandidateChooseItem extends StatelessWidget {
  const CandidateChooseItem({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
  });

  final String value;
  final String? groupValue;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged?.call(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Row(
          children: [
            Expanded(child: Text(value)),
            Container(
              alignment: Alignment.centerRight,
              // width: 150,
              child: Radio(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            )
          ],
        ),
      ),
    );
  }
}
