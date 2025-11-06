part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesUpdated extends FavoritesState {
  final List<ProductModel> favorites;
  FavoritesUpdated(this.favorites);
}

final class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}
