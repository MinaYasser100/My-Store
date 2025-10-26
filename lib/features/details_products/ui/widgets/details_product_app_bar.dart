import 'package:flutter/material.dart';
import 'package:my_store/core/utils/colors.dart';

class DetailsProductAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DetailsProductAppBar({super.key, required this.productTitle});

  final String productTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsTheme().whiteColor,
      elevation: 0,
      leading: IconButton(
        icon: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: ColorsTheme().primaryDark,
              size: 20,
            ),
            Expanded(
              child: Text(
                'Back',
                style: TextStyle(
                  color: ColorsTheme().primaryDark,
                  fontSize: 14,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        onPressed: () => Navigator.pop(context),
      ),
      leadingWidth: 80,
      title: Text(
        productTitle,
        style: TextStyle(
          color: ColorsTheme().primaryDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: ColorsTheme().primaryDark,
          ),
          onPressed: () {
            // TODO: Navigate to cart
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
