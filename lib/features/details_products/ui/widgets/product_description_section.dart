import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';

class ProductDescriptionSection extends StatelessWidget {
  const ProductDescriptionSection({super.key, this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description ?? 'No description available',
            style: AppTextStyles.styleRegular14sp(context).copyWith(
              color: isDark ? ColorsTheme().whiteColor : Colors.black87,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Grown in Gilroy, CA by ${_extractSupplier()}',
            style: AppTextStyles.styleRegular14sp(context).copyWith(
              color: isDark
                  ? ColorsTheme().grayColor
                  : ColorsTheme().secondaryColor,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 100), // Space for bottom button
        ],
      ),
    );
  }

  String _extractSupplier() {
    // You can modify this to extract actual supplier from product data
    return 'Kunisaki Farms';
  }
}
