import 'package:flutter/material.dart';
import 'package:my_store/features/cart/ui/widgets/Cart_Item.dart';

class AllCartItem extends StatelessWidget {
  const AllCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return CartItem();
      },
    );
  }
}
