import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/features/home/manager/cubit/products_cubit.dart';

class ProductsBlocComsumer extends StatelessWidget {
  const ProductsBlocComsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<ProductModel> products = context.read<ProductsCubit>().allProducts;
        if (state is ProductsFeatchLoading) {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (products.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Lottie.asset(
                    'assets/lottie/Empty box.lottie',
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No Products Available',
                    style: AppTextStyles.styleBold18sp(context),
                  ),
                  SizedBox(height: 8),
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
        return SliverList(
          delegate: SliverChildBuilderDelegate((
            BuildContext context,
            int index,
          ) {
            return Card(
              color: ColorsTheme().whiteColor,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      products[index].image!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].title ?? 'Product Name',
                          style: AppTextStyles.styleBold16sp(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          products[index].description ?? 'Product Description',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.styleRegular14sp(
                            context,
                          ).copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }, childCount: 20),
        );
      },
    );
  }
}
