import 'package:flutter/material.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/layout/repo/cart_repo.dart';

class CartNavIconWithBadge extends StatelessWidget {
  const CartNavIconWithBadge({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final iconColor = ColorsTheme().primaryDark;

    return StreamBuilder<int>(
      stream: CartRepoImpl(
        userHiveHelper: getIt<UserHiveHelper>(),
      ).getTotalQuantity(),
      builder: (context, snapshot) {
        final totalQuantity = snapshot.data ?? 0;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                  color: iconColor,
                ),
                if (totalQuantity > 0)
                  Positioned(
                    right: -8,
                    top: -4,
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
            ),
            const SizedBox(height: 4),
            Text('Cart', style: TextStyle(color: iconColor, fontSize: 12)),
            const SizedBox(height: 6),
            Container(
              height: 3,
              width: 30,
              decoration: BoxDecoration(
                color: isSelected ? iconColor : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        );
      },
    );
  }
}
