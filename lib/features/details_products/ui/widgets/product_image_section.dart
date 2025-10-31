import 'package:flutter/material.dart';
import 'package:my_store/core/utils/colors.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 350,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: isDark ? ColorsTheme().secondaryColor : ColorsTheme().whiteColor,
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
                    color: isDark
                        ? ColorsTheme().whiteColor
                        : ColorsTheme().primaryColor,
                  ),
                );
              },
            )
          : _buildErrorImage(),
    );
  }

  Widget _buildErrorImage() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Container(
          color: isDark ? Colors.grey[800] : Colors.grey[200],
          child: Icon(
            Icons.image_not_supported,
            size: 80,
            color: isDark ? Colors.grey[600] : Colors.grey[400],
          ),
        );
      },
    );
  }
}
