import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/favorites/manager/favorites_cubit.dart';

class FavoritesNavIconWithBadge extends StatelessWidget {
  const FavoritesNavIconWithBadge({
    super.key,
    required this.isSelected,
    required this.favoritesCubit,
  });

  final bool isSelected;
  final FavoritesCubit favoritesCubit;

  @override
  Widget build(BuildContext context) {
    final iconColor = ColorsTheme().primaryDark;

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      bloc: favoritesCubit,
      builder: (context, state) {
        final favoritesCount = state is FavoritesUpdated
            ? state.favorites.length
            : 0;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.favorite_border, color: iconColor),
                if (favoritesCount > 0)
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
                        favoritesCount > 99 ? '99+' : '$favoritesCount',
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
            Text('Favorites', style: TextStyle(color: iconColor, fontSize: 12)),
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
