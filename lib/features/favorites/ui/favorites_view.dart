import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/favorites/manager/favorites_cubit.dart';
import 'package:my_store/features/favorites/widgets/custom_favorite_app_bar.dart';
import 'package:my_store/features/favorites/widgets/favorite_empty.dart';
import 'package:my_store/features/favorites/widgets/favorite_list.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          final List<ProductModel> favorites = state is FavoritesUpdated
              ? state.favorites
              : <ProductModel>[];

          return CustomScrollView(
            slivers: [
              const CustomFavoriteAppBar(),

              if (favorites.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: FavoriteEmpty(),
                )
              else
                FavoritesList(
                  favorites: favorites,
                  onRemove: (product) {
                    context.read<FavoritesCubit>().removeFavorite(product);
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
