import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/utils/show_top_toast.dart';
import 'package:my_store/features/favorites/manager/favorites_cubit.dart';
import 'package:my_store/features/favorites/widgets/custom_favorite_app_bar.dart';
import 'package:my_store/features/favorites/widgets/favorite_empty.dart';
import 'package:my_store/features/favorites/widgets/favorite_list.dart';
import 'package:my_store/features/home/data/repo/like_product_repo.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const CustomScrollView(
              slivers: [
                CustomFavoriteAppBar(),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            );
          }

          if (state is FavoritesError) {
            return CustomScrollView(
              slivers: [
                const CustomFavoriteAppBar(),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<FavoritesCubit>().refresh();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

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
                  onRemove: (product) async {
                    // Use LikeProductRepo to remove from Firebase
                    final likeRepo = getIt<LikeProductRepoImpl>();
                    final result = await likeRepo.unlikeProduct(
                      product.id.toString(),
                    );

                    result.fold(
                      (error) {
                        showErrorToast(context, 'Error', error);
                      },
                      (success) {
                        showSuccessToast(
                          context,
                          'Success',
                          'Removed from favorites',
                        );
                        // Update the local state for immediate UI feedback
                        context.read<FavoritesCubit>().removeFavorite(product);
                      },
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
