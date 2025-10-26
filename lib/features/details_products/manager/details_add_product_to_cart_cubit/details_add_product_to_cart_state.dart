part of 'details_add_product_to_cart_cubit.dart';

@immutable
sealed class DetailsAddProductToCartState {}

final class DetailsAddProductToCartInitial
    extends DetailsAddProductToCartState {}

final class DetailsAddProductToCartLoading
    extends DetailsAddProductToCartState {}

final class DetailsAddProductToCartSuccess
    extends DetailsAddProductToCartState {}

final class DetailsAddProductToCartFailure
    extends DetailsAddProductToCartState {
  final String message;
  DetailsAddProductToCartFailure({required this.message});
}
