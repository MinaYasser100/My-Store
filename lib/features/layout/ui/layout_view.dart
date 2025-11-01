import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/utils/constant.dart';
import 'package:my_store/features/add/ui/add_view.dart';
import 'package:my_store/features/cart/data/repo/cart_repo.dart';
import 'package:my_store/features/cart/logic/cart_cubit.dart';
import 'package:my_store/features/cart/ui/cart_view.dart';
import 'package:my_store/features/favorites/data/repo/favorites_repo.dart';
import 'package:my_store/features/favorites/manager/favorites_cubit.dart';
import 'package:my_store/features/favorites/ui/favorites_view.dart';
import 'package:my_store/features/home/ui/home_view.dart';
import 'package:my_store/features/profile/ui/profile_screen.dart';
import 'package:my_store/features/layout/ui/widgets/cart_nav_icon_with_badge.dart';
import 'package:my_store/features/layout/ui/widgets/favorites_nav_icon_with_badge.dart';
import 'package:my_store/features/layout/ui/widgets/layout_nav_icon.dart';
import 'package:my_store/features/profile/ui/profile_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _currentIndex = 0;
  late final CartCubit _cartCubit;
  late final FavoritesCubit _favoritesCubit;

  @override
  void initState() {
    super.initState();
    final userId =
        getIt<UserHiveHelper>().getUser(ConstantVariable.uId)?.uid ?? '';
    _cartCubit = CartCubit(
      repo: CartRepo(firestore: getIt()),
      userId: userId,
    );
    _cartCubit.listenToCart();
    _favoritesCubit = FavoritesCubit(favoritesRepo: getIt<FavoritesRepoImpl>());
  }

  @override
  void dispose() {
    _cartCubit.close();
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
              iconData: Icons.home,
              label: 'Home',
              isSelected: _currentIndex == 0,
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
