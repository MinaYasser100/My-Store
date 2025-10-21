import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/utils/show_top_toast.dart';
import 'package:my_store/features/home/data/repo/add_to_cart_repo.dart';
import 'package:my_store/features/home/data/repo/like_product_repo.dart';
import 'package:my_store/features/home/manager/cart_product_cubit/cart_product_cubit.dart';
import 'package:my_store/features/home/manager/like_product_cubit/like_product_cubit.dart';
import 'package:my_store/features/home/ui/widgets/products_empty_state.dart';
import 'package:my_store/features/home/ui/widgets/products_list.dart';
import 'package:my_store/features/home/ui/widgets/products_loading_state.dart';

import '../manager/products_cubit/products_cubit.dart';

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

        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<LikeProductRepo>.value(
              value: getIt<LikeProductRepoImpl>(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LikeProductCubit>(
                create: (context) =>
                    LikeProductCubit(getIt<LikeProductRepoImpl>()),
              ),
              BlocProvider(
                create: (context) =>
                    CartProductCubit(getIt<AddOrUpdateProductToCartRepoImpl>()),
              ),
            ],
            child: ProductsList(products: products),
          ),
        );
      },
    );
  }

  void _handleStateChanges(BuildContext context, ProductsState state) {
    if (state is ProductsFeatchFailure) {
      showErrorToast(
        context,
        'Error',
        'An error occurred while fetching products.',
      );
    }
  }
}
