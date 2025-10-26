import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceRow(context),
          const SizedBox(height: 12),
          _buildSupplierRow(context),
        ],
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${product.price?.toStringAsFixed(0) ?? '0'} LE each',
          style: AppTextStyles.styleBold16sp(
            context,
          ).copyWith(fontSize: 20, color: ColorsTheme().primaryDark),
        ),
      ],
    );
  }

  Widget _buildSupplierRow(BuildContext context) {
    return Row(
      children: [
        Text(
          product.category ?? 'Unknown Category',
          style: AppTextStyles.styleRegular14sp(context).copyWith(
            color: ColorsTheme().primaryColor,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.arrow_forward_ios,
          size: 12,
          color: ColorsTheme().primaryColor,
        ),
      ],
    );
  }
}
