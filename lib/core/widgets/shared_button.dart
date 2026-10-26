import 'package:arven/core/theme/app_colors.dart';
import 'package:arven/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class SharedButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;

  const SharedButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppColors.black,
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonName,
            style: AppTextStyles.text16Medium.copyWith(
              color: AppColors.textfield,
            ),
          ),
        ),
      ),
    );
  }
}