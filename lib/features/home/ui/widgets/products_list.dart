import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/home/ui/widgets/product_card_item.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return ProductCardItem(
          product: products[index],
          onFavoritePressed: () {
            _handleFavoritePressed(context, products[index]);
          },
          onAddToCartPressed: () {
            _handleAddToCart(context, products[index]);
          },
        );
      }, childCount: products.length),
    );
  }

  void _handleFavoritePressed(BuildContext context, ProductModel product) {
    // TODO: Implement favorite logic
    debugPrint('Favorite pressed: ${product.title}');
  }

  void _handleAddToCart(BuildContext context, ProductModel product) {
    // TODO: Implement add to cart logic
    debugPrint('Add to cart: ${product.title}');
  }
}
