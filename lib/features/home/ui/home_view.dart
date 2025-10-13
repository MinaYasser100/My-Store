import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/home/data/repo/products_repo.dart';
import 'package:my_store/features/home/manager/cubit/products_cubit.dart';
import 'package:my_store/features/home/ui/products_list_view.dart';

import 'custom_home_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsCubit(getIt<ProductsRepoImpl>())..getAllProducts(),
      child: Builder(
        builder: (context) {
          return RefreshIndicator(
            backgroundColor: ColorsTheme().whiteColor,
            color: ColorsTheme().primaryColor,
            displacement: 50,
            strokeWidth: 3,
            onRefresh: () async {
              context.read<ProductsCubit>().getAllProducts();
            },
            child: CustomScrollView(
              slivers: [CustomHomeAppBar(), ProductsBlocComsumer()],
            ),
          );
        },
      ),
    );
  }
}
