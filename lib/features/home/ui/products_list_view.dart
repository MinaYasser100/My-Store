import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/home/manager/cubit/products_cubit.dart';
import 'package:my_store/features/home/ui/widgets/products_empty_state.dart';
import 'package:my_store/features/home/ui/widgets/products_list.dart';
import 'package:my_store/features/home/ui/widgets/products_loading_state.dart';

class ProductsBlocComsumer extends StatelessWidget {
  const ProductsBlocComsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: _handleStateChanges,
      builder: (context, state) {
        final List<ProductModel> products = context
            .read<ProductsCubit>()
            .allProducts;

        if (state is ProductsFeatchLoading) {
          return const ProductsLoadingState();
        }

        if (products.isEmpty) {
          return const ProductsEmptyState();
        }

        return ProductsList(products: products);
      },
    );
  }

  void _handleStateChanges(BuildContext context, ProductsState state) {
    // TODO: Handle state changes like errors or success messages
    if (state is ProductsFeatchFailure) {
      // Show error snackbar or dialog
      debugPrint('Error loading products: ${state.error}');
    }
  }
}
