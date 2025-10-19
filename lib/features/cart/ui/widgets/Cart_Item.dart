import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/cart/data/models/cart_item_model.dart';
import 'package:my_store/features/cart/ui/widgets/dropdown.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItem});
  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.network(
                cartItem.image,
                height: 100,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 80),
              ),

              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cartItem.name,
                      style: AppTextStyles.styleRegular16sp(context),
                    ),
                    Text(
                      "${cartItem.price.toStringAsFixed(2)} LE",
                      style: AppTextStyles.styleRegular16sp(
                        context,
                      ).copyWith(color: ColorsTheme().primaryLight),
                    ),
                    SizedBox(height: 6),

                    ItemQuantityDropdown(
                      initialQuantity: cartItem.quantity,
                      itemId: cartItem.id,
                    ),
                  ],
                ),
              ),

              Text("${cartItem.itemTotal.toStringAsFixed(2)} LE"),
            ],
          ),
          SizedBox(height: 20),
          Divider(),
        ],
      ),
    );
  }
}
