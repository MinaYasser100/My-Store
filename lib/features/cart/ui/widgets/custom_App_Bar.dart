import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  const Customappbar({super.key, required this.Title, this.icon});

  final String Title;
  final IconData? icon;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,

      elevation: 1,
      title: Text(Title, style: TextStyle(color: Colors.black)),
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/images/logo.png",
            width: 20,
            height: 20,
            fit: BoxFit.cover,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Icon(icon, color: Colors.black),
        ),
      ],
    );
  }
}
