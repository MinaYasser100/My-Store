import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/features/cart/ui/widgets/ConfirmAllitems.dart';
import 'package:my_store/features/cart/ui/widgets/custom_App_Bar.dart';
import 'package:my_store/features/cart/ui/widgets/header_checkout.dart';

class ConfirmView extends StatelessWidget {
  const ConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Customappbar(Title: "My store", icon: Icons.shopping_cart),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          HeaderCheckout(),
Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              "Order Confirmation",
              style: AppTextStyles.styleBold23sp(context).copyWith(
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ConfirmAllItems(),
            ),
          ),
        ],
      ),
    );
  }
}
