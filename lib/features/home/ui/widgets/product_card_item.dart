import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/utils/show_top_toast.dart';
import 'package:my_store/features/home/data/repo/like_product_repo.dart';
import 'package:my_store/features/home/manager/cart_product_cubit/cart_product_cubit.dart';
import 'package:my_store/features/home/manager/like_product_cubit/like_product_cubit.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        context.push(Routes.detailsProductView, extra: product);
      },
      child: Card(
        color: isDark ? ColorsTheme().secondaryColor : ColorsTheme().whiteColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            _buildProductImage(),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleWithFavorite(context),
                    const SizedBox(height: 4),
                    _buildDescriptionWithAddButton(context),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: Image.network(
        product.image ?? '',
        width: 100,
        height: 100,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 100,
            height: 100,
            color: Colors.grey[300],
            child: Icon(
              Icons.image_not_supported,
              color: Colors.grey[600],
              size: 40,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitleWithFavorite(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            product.title ?? 'Product Name',
            style: AppTextStyles.styleBold16sp(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _buildLikeButton(context),
      ],
    );
  }

  Widget _buildLikeButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: context.read<LikeProductRepo>().isProductLiked(
        product.id.toString(),
      ),
      builder: (context, snapshot) {
        final isLiked = snapshot.data ?? false;

        return BlocListener<LikeProductCubit, LikeProductState>(
          listener: (context, state) {
            if (state is LikeProductLiked &&
                state.productId == product.id.toString()) {
              showSuccessToast(
                context,
                'Success',
                'Product added to favorites!',
              );
            } else if (state is LikeProductUnliked &&
                state.productId == product.id.toString()) {
              showSuccessToast(
                context,
                'Removed',
                'Product removed from favorites.',
              );
            } else if (state is LikeProductFailure) {
              showErrorToast(context, 'Error', state.error);
            }
          },
          child: GestureDetector(
            onTap: snapshot.hasData
                ? () => context.read<LikeProductCubit>().toggleLikeStatus(
                    product.id.toString(),
                    isLiked,
                  )
                : null,
            child: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : ColorsTheme().primaryDark,
              size: 22,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescriptionWithAddButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            product.description ?? 'Product Description',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.styleRegular14sp(
              context,
            ).copyWith(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(width: 8),
        BlocListener<CartProductCubit, CartProductState>(
          listener: (context, state) {
            if (state is CartProductSuccess) {
              showSuccessToast(context, 'Success', 'Product added to cart!');
            } else if (state is CartProductFailure) {
              showErrorToast(context, 'Error', state.message);
            }
          },
          child: _buildAddToCartButton(() {
            context.read<CartProductCubit>().addProductToCart(product);
          }),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(void Function()? onTap) {
    return Material(
      color: ColorsTheme().primaryDark,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }
}
