import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/cart/data/models/cart_item_model.dart';

class ReadOnlyCartItem extends StatelessWidget {
  final CartItemModel cartItem;
  const ReadOnlyCartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  children: [
                    Text(
                      cartItem.title,
                      style: AppTextStyles.styleRegular16sp(context),
                      maxLines: 2,
                    ),
                    Text(
                      "${cartItem.price.toStringAsFixed(2)} LE",
                      style: AppTextStyles.styleRegular16sp(context).copyWith(
                        color: ColorsTheme().primaryLight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Quantity: ${cartItem.quantity}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
             
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
        ],
      ),
    );
  }
}
