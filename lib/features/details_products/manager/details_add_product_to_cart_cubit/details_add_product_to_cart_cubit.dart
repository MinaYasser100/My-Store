import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/details_products/data/repo/add_product_to_cart_repo.dart';

part 'details_add_product_to_cart_state.dart';

class DetailsAddProductToCartCubit extends Cubit<DetailsAddProductToCartState> {
  DetailsAddProductToCartCubit(this._addProductToCartRepo)
    : super(DetailsAddProductToCartInitial());
  final AddProductToCartRepo _addProductToCartRepo;

  Future<void> addProductToCart({
    required ProductModel product,
    required int quantity,
  }) async {
    emit(DetailsAddProductToCartLoading());
    try {
      final result = await _addProductToCartRepo.addProductToCart(
        productModel: product,
        quantity: quantity,
      );
      result.fold(
        (failureMessage) {
          emit(DetailsAddProductToCartFailure(message: failureMessage));
        },
        (_) {
          emit(DetailsAddProductToCartSuccess());
        },
      );
    } catch (e) {
      emit(
        DetailsAddProductToCartFailure(message: 'An unexpected error occurred'),
      );
    }
  }
}
