import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';

class HeaderCheckout extends StatelessWidget {
  const HeaderCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorsTheme().primaryDark.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Checkout", style: AppTextStyles.styleBold23sp(context)),
          TextButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            child: Text("back", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
