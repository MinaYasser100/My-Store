import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/widgets/custom_button.dart';
import 'package:my_store/features/cart/ui/widgets/All_cart_item.dart';
import 'package:my_store/features/cart/ui/widgets/custom_App_Bar.dart';
import 'package:my_store/features/cart/ui/widgets/total_Cart_section.dart';

class CartProductsView extends StatelessWidget {
  const CartProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight + 30),
          child: CustomScrollView(
            slivers: [
              AllCartItem(),
              const SliverToBoxAdapter(child: TotalCartSection()),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Customappbar(Title: "My Cart", icon: Icons.search),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 5,
          child: CustomButton(
            text: "Proceed to checkout",
            onPressed: () {
              GoRouter.of(context).push(Routes.checkoutview);
            },
          ),
        ),
      ],
    );
  }
}
