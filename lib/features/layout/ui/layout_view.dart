import 'package:flutter/material.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/add/ui/add_view.dart';
import 'package:my_store/features/layout/repo/cart_repo.dart';
import 'package:my_store/features/layout/cart_cubit/cart_cubit.dart';
import 'package:my_store/features/cart/ui/cart_view.dart';
import 'package:my_store/features/favorites/data/repo/favorites_repo.dart';
import 'package:my_store/features/favorites/ui/favorites_view.dart';
import 'package:my_store/features/home/ui/home_view.dart';
import 'package:my_store/features/profile/ui/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/features/favorites/manager/favorites_cubit.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _currentIndex = 0;
  final CartCubit _cartCubit = CartCubit(getIt<CartRepoImpl>());
  late final FavoritesCubit _favoritesCubit;

  @override
  void initState() {
    super.initState();
    _favoritesCubit = FavoritesCubit(favoritesRepo: getIt<FavoritesRepoImpl>());
  }

  @override
  void dispose() {
    _cartCubit.close();
    _favoritesCubit.close();
    super.dispose();
  }

  List<Widget> screens = const [
    HomeView(),
    CartView(),
    AddView(),
    FavoritesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final iconColor = ColorsTheme().primaryDark;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget buildIcon(IconData iconData, String label, int index) {
      final isSelected = index == _currentIndex;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, color: iconColor),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: iconColor, fontSize: 12)),
          const SizedBox(height: 6),
          // underline that appears only for selected item and spans under icon+label
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
    }

    Widget buildCartIconWithBadge(int index) {
      final isSelected = index == _currentIndex;
      return StreamBuilder<int>(
        stream: _cartCubit.getTotalQuantity(),
        builder: (context, snapshot) {
          final totalQuantity = snapshot.data ?? 0;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.shopping_cart_outlined, color: iconColor),
                  if (totalQuantity > 0)
                    Positioned(
                      right: -8,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
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

    Widget buildFavoritesIconWithBadge(int index) {
      final isSelected = index == _currentIndex;
      return BlocBuilder<FavoritesCubit, FavoritesState>(
        bloc: _favoritesCubit,
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
                        decoration: BoxDecoration(
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
              Text(
                'Favorites',
                style: TextStyle(color: iconColor, fontSize: 12),
              ),
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

    return Scaffold(
      body: BlocProvider.value(
        value: _favoritesCubit,
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark
            ? ColorsTheme().secondaryColor
            : ColorsTheme().whiteColor,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(
            icon: buildIcon(Icons.home, 'Home', 0),
            label: '',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: buildCartIconWithBadge(1),
            label: '',
            tooltip: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.add, 'Add', 2),
            label: '',
            tooltip: 'Add',
          ),
          BottomNavigationBarItem(
            icon: buildFavoritesIconWithBadge(3),
            label: '',
            tooltip: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.person_outline, 'Profile', 4),
            label: '',
            tooltip: 'Profile',
          ),
        ],
      ),
    );
  }
}
