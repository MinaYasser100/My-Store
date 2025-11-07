import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // color: Colors.blue,
        boxShadow: [
          BoxShadow(
            color: ColorsTheme().primaryDark.withOpacity(0),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsTheme().primaryDark,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          ),
          onPressed: onPressed,
          child: Text(text, style: AppTextStyles.styleBold16sp(context)),
        ),
      ),
    );
  }
}
