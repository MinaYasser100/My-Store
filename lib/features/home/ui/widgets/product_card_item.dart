import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    super.key,
    required this.product,
    this.onFavoritePressed,
    this.onAddToCartPressed,
  });

  final ProductModel product;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onAddToCartPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsTheme().whiteColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildProductImage(),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleWithFavorite(context),
                  const SizedBox(height: 4),
                  _buildDescriptionWithAddButton(context),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: Image.network(
        product.image ?? '',
        width: 100,
        height: 100,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 100,
            height: 100,
            color: Colors.grey[300],
            child: Icon(
              Icons.image_not_supported,
              color: Colors.grey[600],
              size: 40,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitleWithFavorite(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            product.title ?? 'Product Name',
            style: AppTextStyles.styleBold16sp(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: ColorsTheme().primaryColor,
            size: 22,
          ),
          onPressed: onFavoritePressed,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildDescriptionWithAddButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            product.description ?? 'Product Description',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.styleRegular14sp(
              context,
            ).copyWith(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(width: 8),
        _buildAddToCartButton(),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return Material(
      color: ColorsTheme().primaryDark,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onAddToCartPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }
}
