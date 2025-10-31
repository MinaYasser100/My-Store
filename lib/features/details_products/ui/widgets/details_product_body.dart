import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/details_products/ui/widgets/product_description_section.dart';
import 'package:my_store/features/details_products/ui/widgets/product_image_section.dart';
import 'package:my_store/features/details_products/ui/widgets/product_info_section.dart';
import 'package:my_store/features/details_products/ui/widgets/add_to_basket_section.dart';

class DetailsProductBody extends StatelessWidget {
  const DetailsProductBody({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImageSection(imageUrl: product.image),
                ProductInfoSection(product: product),
                ProductDescriptionSection(description: product.description),
              ],
            ),
          ),
        ),
        AddToBasketSection(product: product),
      ],
    );
  }
}
