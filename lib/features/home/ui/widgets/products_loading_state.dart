import 'package:flutter/material.dart';

class ProductsLoadingState extends StatelessWidget {
  const ProductsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
