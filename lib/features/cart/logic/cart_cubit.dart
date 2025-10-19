import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/features/cart/data/repo/cart_repo.dart';
import 'package:my_store/features/cart/logic/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo repo;
  final String userId;

  CartCubit({required this.repo, required this.userId}) : super(CartInitial());

  void listenToCart() {
    emit(CartLoading());
    repo
        .getUserCart(userId)
        .listen(
          (cartItems) {
            cartItems.forEach((item) {});

            final subtotal = cartItems.fold<double>(
              0.0,
              (sum, item) => sum + item.itemTotal,
            );
            emit(CartLoaded(cartItems: cartItems, subtotal: subtotal));
          },
          onError: (err) {
            emit(CartError(err.toString()));
          },
        );
  }

  Future<void> changeQuantity(String itemId, int newQuantity) async {
    await repo.updateQuantity(userId, itemId, newQuantity);
  }
}
