import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/utils/show_top_toast.dart';
import 'package:my_store/features/details_products/manager/details_add_product_to_cart_cubit/details_add_product_to_cart_cubit.dart';
import 'package:my_store/features/details_products/ui/widgets/add_to_basket_button.dart';
import 'package:my_store/features/details_products/ui/widgets/quantity_selector.dart';

class AddToBasketSection extends StatefulWidget {
  const AddToBasketSection({super.key, required this.product});

  final ProductModel product;

  @override
  State<AddToBasketSection> createState() => _AddToBasketSectionState();
}

class _AddToBasketSectionState extends State<AddToBasketSection> {
  int _quantity = 1;
  bool _isLoading = false;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToBasket() {
    final cubit = context.read<DetailsAddProductToCartCubit>();

    setState(() {
      _isLoading = true;
    });

    cubit.addProductToCart(product: widget.product, quantity: _quantity);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      DetailsAddProductToCartCubit,
      DetailsAddProductToCartState
    >(
      listener: (context, state) {
        if (state is DetailsAddProductToCartSuccess) {
          setState(() {
            _isLoading = false;
          });
          showSuccessToast(
            context,
            'Success',
            'Added $_quantity of this product to cart',
          );
        } else if (state is DetailsAddProductToCartFailure) {
          setState(() {
            _isLoading = false;
          });
          showErrorToast(context, 'Error', state.message);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorsTheme().whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              QuantitySelector(
                quantity: _quantity,
                onIncrement: _incrementQuantity,
                onDecrement: _decrementQuantity,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AddToBasketButton(
                  onPressed: _addToBasket,
                  isLoading: _isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
