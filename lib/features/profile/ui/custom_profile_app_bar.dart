import 'package:flutter/material.dart';

class CustomProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 4.0, bottom: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
        ),
      ),
      title: Text(
        'My Profile',
        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: theme.iconTheme.color),
          onPressed: () {
            // TODO: Implement search in favorites
          },
        ),
      ],
    );
  }
}
