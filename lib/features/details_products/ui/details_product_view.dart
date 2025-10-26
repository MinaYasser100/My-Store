import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/details_products/ui/widgets/details_product_app_bar.dart';
import 'package:my_store/features/details_products/ui/widgets/details_product_body.dart';

class DetailsProductView extends StatelessWidget {
  const DetailsProductView({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailsProductAppBar(productTitle: product.title ?? ''),
      body: DetailsProductBody(product: product),
    );
  }
}
