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
        return ProductCardItem(product: products[index]);
      }, childCount: products.length),
    );
  }
}
