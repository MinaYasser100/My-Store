import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';

class FavoriteTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onRemove;

  const FavoriteTile({
    super.key,
    required this.product,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.network(
          product.image ?? "",
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.title ?? ""),
        subtitle: Text("\$${product.price?.toStringAsFixed(2) ?? "0.00"}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
