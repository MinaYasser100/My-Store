import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/widgets/custom_button.dart';
import 'package:my_store/features/cart/logic/cart_cubit.dart';
import 'package:my_store/features/cart/logic/cart_state.dart';
import 'package:my_store/features/cart/ui/widgets/readonlycartitem.dart';
import 'package:my_store/features/cart/ui/widgets/total_Cart_section.dart';
class ConfirmAllItems extends StatelessWidget {
  const ConfirmAllItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is CartLoaded) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          return ReadOnlyCartItem(
                            cartItem: state.cartItems[index],
                          );
                        },
                      ),

                      const TotalCartSection(),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Taxes',
                              style: AppTextStyles.styleBold23sp(context),
                            ),
                            Text(
                              "10 LE",
                              style: AppTextStyles.styleBold18sp(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: CustomButton(
                  text: 'Confirm Order',
                  onPressed: () {
                    GoRouter.of(context).push(Routes.orderSuccessView);
                  },
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
