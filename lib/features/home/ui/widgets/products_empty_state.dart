import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_store/core/theme/app_style.dart';

class ProductsEmptyState extends StatelessWidget {
  const ProductsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Lottie.asset(
              'assets/lottie/Empty box.lottie',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              'No Products Available',
              style: AppTextStyles.styleBold18sp(context),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later for new products',
              style: AppTextStyles.styleRegular14sp(
                context,
              ).copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
