import 'package:flutter/material.dart';

class CustomFavoriteAppBar extends StatelessWidget {
  const CustomFavoriteAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      pinned: true,
      expandedHeight: 80.0,
      backgroundColor: theme.scaffoldBackgroundColor,
      actionsPadding: const EdgeInsets.all(10),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 4.0, bottom: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
        ),
      ),
      title: Text(
        'My Favorites',
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
