import 'package:my_store/features/cart/data/models/cart_item_model.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  final double subtotal;

  const CartLoaded({required this.cartItems, required this.subtotal});
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);
}
