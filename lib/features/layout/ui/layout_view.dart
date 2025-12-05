import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/add/ui/add_view.dart';
import 'package:my_store/features/cart/ui/views/cart_view.dart';
import 'package:my_store/features/favorites/data/repo/favorites_repo.dart';
import 'package:my_store/features/favorites/manager/favorites_cubit.dart';
import 'package:my_store/features/favorites/ui/favorites_view.dart';
import 'package:my_store/features/home/ui/home_view.dart';
import 'package:my_store/features/profile/ui/profile_screen.dart';
import 'package:my_store/features/layout/ui/widgets/cart_nav_icon_with_badge.dart';
import 'package:my_store/features/layout/ui/widgets/favorites_nav_icon_with_badge.dart';
import 'package:my_store/features/layout/ui/widgets/layout_nav_icon.dart';

class LayoutView extends StatefulWidget {
  final int initialIndex;
  const LayoutView({super.key, this.initialIndex = 0});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _currentIndex = 0;
  late final FavoritesCubit _favoritesCubit;

  @override
  void initState() {
    super.initState();
    _favoritesCubit = FavoritesCubit(favoritesRepo: getIt<FavoritesRepoImpl>());
    _currentIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _favoritesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screens = [
      const HomeView(),
      const CartView(),
      const AddView(),
      const FavoritesView(),
      ProfileScreen(),
    ];

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
            icon: LayoutNavIcon(
              iconData: Icons.home_outlined,
              activeIconData: Icons.home,
              label: 'Home',
              isSelected: false,
            ),
            activeIcon: LayoutNavIcon(
              iconData: Icons.home_outlined,
              activeIconData: Icons.home,
              label: 'Home',
              isSelected: true,
            ),
            label: '',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CartNavIconWithBadge(isSelected: _currentIndex == 1),
            label: '',
            tooltip: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: LayoutNavIcon(
              iconData: Icons.add,
              label: 'Add',
              isSelected: _currentIndex == 2,
            ),
            label: '',
            tooltip: 'Add',
          ),
          BottomNavigationBarItem(
            icon: FavoritesNavIconWithBadge(
              isSelected: _currentIndex == 3,
              favoritesCubit: _favoritesCubit,
            ),
            label: '',
            tooltip: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: LayoutNavIcon(
              iconData: Icons.person_outline,
              activeIconData: Icons.person,
              label: 'Profile',
              isSelected: _currentIndex == 4,
            ),
            label: '',
            tooltip: 'Profile',
          ),
        ],
      ),
    );
  }
}
