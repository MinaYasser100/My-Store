import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'favorite_tile.dart';

class FavoritesList extends StatelessWidget {
  final List<ProductModel> favorites;
  final Function(ProductModel) onRemove;

  const FavoritesList({
    super.key,
    required this.favorites,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final product = favorites[index];
        return FavoriteTile(
          product: product,
          onRemove: () => onRemove(product),
        );
      }, childCount: favorites.length),
    );
  }
}
