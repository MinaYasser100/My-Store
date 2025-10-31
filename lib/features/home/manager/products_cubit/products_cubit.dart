import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/home/data/repo/products_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepo) : super(ProductsInitial());
  final ProductsRepo _productsRepo;

  List<ProductModel> allProducts = [];
  void getAllProducts() {
    emit(ProductsFeatchLoading());
    _productsRepo.getAllProducts().listen((event) {
      event.fold((l) => emit(ProductsFeatchFailure(l)), (r) {
        allProducts = r;
        emit(ProductsFeatchSuccess(r));
      });
    });
  }
}
