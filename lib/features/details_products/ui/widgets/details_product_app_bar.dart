import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/details_products/ui/widgets/cart_icon_with_badge.dart';
import 'package:my_store/features/layout/repo/cart_repo.dart';

class DetailsProductAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DetailsProductAppBar({
    super.key,
    required this.productTitle,
    required this.cartRepo,
  });

  final String productTitle;
  final CartRepo cartRepo;

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
        CartIconWithBadge(
          cartRepo: cartRepo,
          onPressed: () {
            context.push(Routes.cartView);
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
