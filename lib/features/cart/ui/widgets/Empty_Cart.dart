import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/widgets/custom_button.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ColorsTheme().grayColor,
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Your cart is empty!"),
              const SizedBox(height: 10),
              const Text(
                "Head back to the products page to check out our produce",
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: "Back To Home",
                onPressed: () {
                  // GoRouter.of(context).push(Routes.homeView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
