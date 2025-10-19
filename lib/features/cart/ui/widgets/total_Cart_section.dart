import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/features/cart/logic/cart_cubit.dart';
import 'package:my_store/features/cart/logic/cart_state.dart';


class TotalCartSection extends StatelessWidget {
  const TotalCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        double subtotal = 0.0;
        if (state is CartLoaded) {
          subtotal = state.subtotal;
        }
        return Container(
          padding: EdgeInsets.all(22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: AppTextStyles.styleBold23sp(context)),
              Text("${subtotal.toStringAsFixed(2)} LE",
                  style: AppTextStyles.styleBold18sp(context)),
            ],
          ),
        );
      },
    );
  }
}
