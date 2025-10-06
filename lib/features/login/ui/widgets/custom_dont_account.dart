import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/utils/colors.dart';

class CustomDontAccount extends StatelessWidget {
  const CustomDontAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.push(Routes.registerView);
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: ColorsTheme().primaryColor),
          ),
        ),
      ],
    );
  }
}
