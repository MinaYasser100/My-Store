import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/features/cart/logic/cart_cubit.dart';
import 'package:my_store/features/cart/logic/cart_state.dart';
import 'package:my_store/features/cart/ui/widgets/CartProductsView.dart';

import 'package:my_store/features/cart/ui/widgets/Empty_Cart.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
          final isEmpty = state.cartItems.isEmpty;

          return isEmpty ? const EmptyCart() : const CartProductsView();
        } else if (state is CartError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
   
  }
}
