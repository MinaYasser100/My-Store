import 'package:flutter/material.dart';

import 'package:my_store/features/cart/ui/widgets/custom_App_Bar.dart';
import 'package:my_store/features/cart/ui/widgets/header_checkout.dart';
import 'package:my_store/features/cart/ui/widgets/paymentform.dart';


class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Customappbar(Title: "My store", icon: Icons.shopping_cart),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeaderCheckout(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Paymentform(),
            ),
          ],
        ),
      ),
    );
  }
}