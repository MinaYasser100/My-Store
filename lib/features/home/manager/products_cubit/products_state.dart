part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsFeatchLoading extends ProductsState {}

final class ProductsFeatchSuccess extends ProductsState {
  final List<ProductModel> products;
  ProductsFeatchSuccess(this.products);
}

final class ProductsFeatchFailure extends ProductsState {
  final String error;
  ProductsFeatchFailure(this.error);
}
