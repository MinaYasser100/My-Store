import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget {
  const Customappbar({super.key, required this.Title,  this.icon});
  final String Title;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Text(Title),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/images/logo.png"),
          backgroundColor: Colors.transparent,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Icon(icon),
        ),
      ],
    );
  }
}
