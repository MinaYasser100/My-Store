import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/model/product_model/product_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => List.unmodifiable(_favorites);

  void addFavorite(ProductModel product) {
    if (!_favorites.contains(product)) {
      _favorites.add(product);
      emit(FavoritesUpdated(List.unmodifiable(_favorites)));
    }
  }

  void removeFavorite(ProductModel product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
      emit(FavoritesUpdated(List.unmodifiable(_favorites)));
    }
  }
}
