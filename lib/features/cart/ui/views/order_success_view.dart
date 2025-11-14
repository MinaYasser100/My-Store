import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/widgets/custom_button.dart';
import 'package:my_store/features/cart/logic/cart_cubit.dart';
import 'package:my_store/features/cart/logic/cart_state.dart';
import 'package:my_store/features/cart/ui/widgets/custom_App_Bar.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Customappbar(Title: "My store", icon: Icons.shopping_cart),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "Order Confirmation",
                    style: AppTextStyles.styleBold23sp(context).copyWith(
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Check icon
                  Center(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F0FE),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF0B57D0),
                        size: 56,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      "Order confirmed!",
                      style: AppTextStyles.styleBold23sp(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Your order is being prepared and will be shipped soon.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.styleRegular16sp(context)
                          .copyWith(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Invoice Section
                  if (state is CartLoaded) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Invoice",
                            style: AppTextStyles.styleBold18sp(context),
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          
                          // Cart Items
                          ...state.cartItems.map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item.title,
                                    style: AppTextStyles.styleRegular14sp(context),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "x${item.quantity}",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.styleRegular14sp(context)
                                        .copyWith(color: Colors.black54),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${item.itemTotal.toStringAsFixed(2)} LE",
                                    textAlign: TextAlign.right,
                                    style: AppTextStyles.styleMedium14sp(context),
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                          
                          const Divider(),
                          
                          // Subtotal
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: AppTextStyles.styleRegular16sp(context),
                                ),
                                Text(
                                  "${state.subtotal.toStringAsFixed(2)} LE",
                                  style: AppTextStyles.styleMedium16sp(context),
                                ),
                              ],
                            ),
                          ),
                          
                          // Taxes
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Taxes",
                                  style: AppTextStyles.styleRegular16sp(context),
                                ),
                                Text(
                                  "10.00 LE",
                                  style: AppTextStyles.styleMedium16sp(context),
                                ),
                              ],
                            ),
                          ),
                          
                          const Divider(thickness: 2),
                          
                          // Total
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: AppTextStyles.styleBold18sp(context),
                                ),
                                Text(
                                  "${(state.subtotal + 10).toStringAsFixed(2)} LE",
                                  style: AppTextStyles.styleBold18sp(context)
                                      .copyWith(color: const Color(0xFF0B57D0)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Order details card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Details",
                          style: AppTextStyles.styleBold18sp(context),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Delivery to",
                                      style: AppTextStyles.styleMedium14sp(context)
                                          .copyWith(color: Colors.black54)),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Your saved address",
                                    style: AppTextStyles.styleRegular16sp(context),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Estimated delivery",
                                      style: AppTextStyles.styleMedium14sp(context)
                                          .copyWith(color: Colors.black54)),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Monday, October 20, 2025",
                                    style: AppTextStyles.styleRegular16sp(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // What happens next
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What happens next?",
                          style: AppTextStyles.styleBold18sp(context),
                        ),
                        const SizedBox(height: 8),
                        _Bullet(text: "We'll prepare your fresh produce order"),
                        _Bullet(text: "Your order will be packed and shipped"),
                        _Bullet(text: "Delivered fresh to your door"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: CustomButton(
          text: 'Continue shopping',
          onPressed: () async {
            try {
              await context.read<CartCubit>().clearCart();
            } catch (_) {}
            GoRouter.of(context).pushReplacement(Routes.layoutView);
          },
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 8, color: Color(0xFF0B57D0)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.styleRegular16sp(context),
            ),
          ),
        ],
      ),
    );
  }
}
