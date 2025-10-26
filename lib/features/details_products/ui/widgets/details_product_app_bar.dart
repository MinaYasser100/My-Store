import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/routes.dart';
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
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Row(
          children: [
            Icon(Icons.arrow_back_ios, color: theme.iconTheme.color, size: 20),
            Expanded(
              child: Text(
                'Back',
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
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
          color: theme.textTheme.bodyLarge?.color,
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
