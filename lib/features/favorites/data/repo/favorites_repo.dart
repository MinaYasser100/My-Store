import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/favorites/data/service/favorites_service.dart';

abstract class FavoritesRepo {
  Stream<List<ProductModel>> getFavoriteProducts();
}

class FavoritesRepoImpl implements FavoritesRepo {
  final FavoritesService favoritesService;

  FavoritesRepoImpl({required this.favoritesService});

  @override
  Stream<List<ProductModel>> getFavoriteProducts() {
    try {
      return favoritesService.getFavoriteProducts();
    } catch (e) {
      return Stream.value([]);
    }
  }
}
