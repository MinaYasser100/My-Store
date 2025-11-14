import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  const Customappbar({super.key, required this.Title, this.icon});

  final String Title;
  final IconData? icon;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      title: Text(
        Title,
        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 4.0, bottom: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
        ),
      ),
      actions: [
        if (icon != null)
          IconButton(
            icon: Icon(icon, color: theme.iconTheme.color),
            onPressed: () {
              // TODO: Implement action
            },
          ),
      ],
      actionsPadding: const EdgeInsets.all(10),
    );
  }
}
