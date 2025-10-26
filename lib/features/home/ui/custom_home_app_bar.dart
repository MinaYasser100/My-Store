import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/theme/theme_cubit/theme_cubit.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 80.0,
      actionsPadding: const EdgeInsets.all(10),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 4.0, bottom: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
        ),
      ),
      title: const Text('My Store'),
      actions: [
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            final isDark = state is ThemeDark;
            return IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              tooltip: isDark ? 'Light Mode' : 'Dark Mode',
            );
          },
        ),
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ],
    );
  }
}
