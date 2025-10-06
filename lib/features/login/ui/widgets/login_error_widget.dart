import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';

class LoginErrorWidget extends StatelessWidget {
  const LoginErrorWidget({super.key, required this.error});
  final String error;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsTheme().errorColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          error,
          style: AppTextStyles.styleRegular14sp(
            context,
          ).copyWith(color: ColorsTheme().errorColor),
        ),
      ),
    );
  }
}
