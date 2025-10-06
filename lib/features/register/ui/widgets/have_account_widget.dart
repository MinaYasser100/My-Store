import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/login/ui/login_view.dart';

class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?'),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(fromVerifyEmail: false),
              ),
            );
          },
          style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
          child: Text(
            'Sign In',
            style: AppTextStyles.styleBold18sp(
              context,
            ).copyWith(color: ColorsTheme().primaryDark),
          ),
        ),
      ],
    );
  }
}
