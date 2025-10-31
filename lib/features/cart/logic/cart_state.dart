import 'package:equatable/equatable.dart';
import 'package:my_store/features/cart/data/models/cart_item_model.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}
class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  final double subtotal;

  CartLoaded({required this.cartItems, required this.subtotal});

  @override
  List<Object?> get props => [cartItems, subtotal];
}
class CartError extends CartState {
  final String message;
  CartError(this.message);
  @override
  List<Object?> get props => [message];
}
