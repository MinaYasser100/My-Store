import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/dependency_injection/set_up_dependencies.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/details_products/data/repo/add_product_to_cart_repo.dart';
import 'package:my_store/features/details_products/manager/details_add_product_to_cart_cubit/details_add_product_to_cart_cubit.dart';
import 'package:my_store/features/details_products/ui/widgets/details_product_app_bar.dart';
import 'package:my_store/features/details_products/ui/widgets/details_product_body.dart';
import 'package:my_store/features/layout/repo/cart_repo.dart';

class DetailsProductView extends StatelessWidget {
  const DetailsProductView({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DetailsAddProductToCartCubit(getIt<AddProductToCartRepoImpl>()),
        ),
      ],
      child: Scaffold(
        appBar: DetailsProductAppBar(
          productTitle: product.title ?? '',
          cartRepo: getIt<CartRepoImpl>(),
        ),
        body: DetailsProductBody(product: product),
      ),
    );
  }
}
