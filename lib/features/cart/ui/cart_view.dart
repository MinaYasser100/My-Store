import 'package:flutter/material.dart';
import 'package:my_store/features/cart/ui/widgets/CartProductsView.dart';

import 'package:my_store/features/cart/ui/widgets/Empty_Cart.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final bool IsEmpty = false;
  @override
  Widget build(BuildContext context) {
    return IsEmpty ? const EmptyCart() : CartProductsView();
  }
}
