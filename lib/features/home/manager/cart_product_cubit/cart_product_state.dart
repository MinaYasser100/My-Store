part of 'cart_product_cubit.dart';

@immutable
sealed class CartProductState {}

final class CartProductInitial extends CartProductState {}

final class CartProductLoading extends CartProductState {}

final class CartProductSuccess extends CartProductState {}

final class CartProductFailure extends CartProductState {
  CartProductFailure(this.message);

  final String message;
}
