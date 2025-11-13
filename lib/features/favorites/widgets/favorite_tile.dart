import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/widgets/product_image.dart'; // <-- 1. إضافة الإمبورت

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
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: theme.cardColor,
      child: ListTile(
        // --- 2. تم استبدال الكود القديم بالكود الجديد ---
        leading: ProductImageWidget(
          imageString: product.image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          borderRadius: 8.0, // نفس الـ radius اللي كان موجود
        ),
        // ------------------------------------------
        title: Text(
          product.title ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          "${product.price?.toStringAsFixed(0) ?? "0"} LE",
          style: TextStyle(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: onRemove,
          tooltip: 'Remove from favorites',
        ),
      ),
    );
  }
}