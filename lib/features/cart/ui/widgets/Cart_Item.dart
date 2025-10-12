import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/cart/ui/widgets/dropdown.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

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
              Image.asset("assets/images/logo.png", height: 100, width: 80),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "name item",
                      style: AppTextStyles.styleRegular16sp(context),
                    ),
                    Text(
                      "41.00LE",
                      style: AppTextStyles.styleRegular16sp(
                        context,
                      ).copyWith(color: ColorsTheme().primaryLight),
                    ),
                    SizedBox(height: 6),
                    ItemQuantityDropdown(),
                  ],
                ),
              ),

              Text("41.00LE"),
            ],
          ),
          SizedBox(height: 20),
          Divider(),
        ],
      ),
    );
  }
}
