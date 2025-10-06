import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';

class CustomSuccesRegisterMessage extends StatelessWidget {
  const CustomSuccesRegisterMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsTheme().successColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Registration successful! Please sign in with your new account.',
          textAlign: TextAlign.center,
          style: AppTextStyles.styleBold14sp(
            context,
          ).copyWith(color: ColorsTheme().successColor),
        ),
      ),
    );
  }
}
