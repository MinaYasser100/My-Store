import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';

class SearchResultItem extends StatelessWidget {
  final ProductModel product;

  const SearchResultItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: product.image != null
            ? Image.network(product.image!, width: 60, height: 60, fit: BoxFit.cover)
            : const Icon(Icons.image_not_supported),
        title: Text(
          product.title ?? 'No title',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          product.description ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          product.price != null ? '\$${product.price!.toStringAsFixed(2)}' : '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
