import 'package:flutter/material.dart';
import 'package:my_store/core/utils/colors.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      color: ColorsTheme().whiteColor,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Image.network(
              imageUrl!,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return _buildErrorImage();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorsTheme().primaryColor,
                  ),
                );
              },
            )
          : _buildErrorImage(),
    );
  }

  Widget _buildErrorImage() {
    return Container(
      color: Colors.grey[200],
      child: Icon(Icons.image_not_supported, size: 80, color: Colors.grey[400]),
    );
  }
}
