import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/features/layout/repo/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo;

  CartCubit(this._cartRepo) : super(CartInitial());

  Stream<int> getTotalQuantity() {
    return _cartRepo.getTotalQuantity();
  }
}
