import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/favorites/data/repo/favorites_repo.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo favoritesRepo;
  StreamSubscription<List<ProductModel>>? _favoritesSubscription;

  FavoritesCubit({required this.favoritesRepo}) : super(FavoritesInitial()) {
    _loadFavorites();
  }

  void _loadFavorites() {
    emit(FavoritesLoading());

    _favoritesSubscription = favoritesRepo.getFavoriteProducts().listen(
      (favorites) {
        emit(FavoritesUpdated(favorites));
      },
      onError: (error) {
        emit(FavoritesError('Failed to load favorites: $error'));
      },
    );
  }

  void removeFavorite(ProductModel product) {
    // The removal is handled by LikeProductRepo
    // This cubit just listens to the stream and updates automatically
    // We emit the current state minus the removed product immediately for UI responsiveness
    if (state is FavoritesUpdated) {
      final currentFavorites = (state as FavoritesUpdated).favorites;
      final updatedFavorites = currentFavorites
          .where((p) => p.id != product.id)
          .toList();
      emit(FavoritesUpdated(updatedFavorites));
    }
  }

  void refresh() {
    _loadFavorites();
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
