import 'package:flutter/material.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/add/ui/add_view.dart';
import 'package:my_store/features/cart/ui/cart_view.dart';
import 'package:my_store/features/favorites/ui/favorites_view.dart';
import 'package:my_store/features/home/ui/home_view.dart';
import 'package:my_store/features/profile/ui/profile_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _currentIndex = 0;
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

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsTheme().whiteColor,
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
            icon: buildIcon(Icons.shopping_cart_outlined, 'Cart', 1),
            label: '',
            tooltip: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.add, 'Add', 2),
            label: '',
            tooltip: 'Add',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.favorite_border, 'Favorites', 3),
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
