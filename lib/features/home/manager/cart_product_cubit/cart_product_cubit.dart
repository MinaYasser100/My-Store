import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/features/home/data/repo/add_to_cart_repo.dart';

part 'cart_product_state.dart';

class CartProductCubit extends Cubit<CartProductState> {
  CartProductCubit(this._addToCartRepo) : super(CartProductInitial());

  final AddOrUpdateProductToCartRepo _addToCartRepo;

  void addProductToCart(String productId) {
    try {
      emit(CartProductLoading());
      _addToCartRepo.addOrUpdateToCart(productId: productId).then((either) {
        either.fold(
          (failureMessage) {
            emit(CartProductFailure(failureMessage));
          },
          (_) {
            emit(CartProductSuccess());
          },
        );
      });
    } catch (e) {
      emit(CartProductFailure('An unexpected error occurred.'));
    }
  }
}
