import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';

class SearchResultItem extends StatelessWidget {
  final ProductModel product;

  const SearchResultItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: product.image != null
          ? Image.network(product.image!, width: 50, height: 50, fit: BoxFit.cover)
          : const Icon(Icons.image_not_supported),
      title: Text(product.title ?? 'Unknown Product'),
      subtitle: Text(product.description ?? ''),
    );
  }
}
