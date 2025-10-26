import 'package:flutter/material.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 80.0,
      actionsPadding: EdgeInsets.all(10),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 4.0, bottom: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
        ),
      ),
      title: Text('My Store'),
      actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
    );
  }
}
