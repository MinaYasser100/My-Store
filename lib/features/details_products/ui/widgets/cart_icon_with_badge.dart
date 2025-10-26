import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/features/layout/repo/cart_repo.dart';

class CartIconWithBadge extends StatelessWidget {
  const CartIconWithBadge({super.key, required this.cartRepo, this.onPressed});

  final CartRepo cartRepo;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<int>(
      stream: cartRepo.getTotalQuantity(),
      builder: (context, snapshot) {
        final totalQuantity = snapshot.data ?? 0;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: theme.iconTheme.color,
              ),
              onPressed: onPressed,
            ),
            if (totalQuantity > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    totalQuantity > 99 ? '99+' : '$totalQuantity',
                    style: AppTextStyles.styleBold10sp(
                      context,
                    ).copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
