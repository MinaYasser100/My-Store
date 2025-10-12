import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';

class TotalCartSection extends StatelessWidget {
  const TotalCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Subtotal', style: AppTextStyles.styleBold23sp(context)),
          Text("34.00LE", style: AppTextStyles.styleBold18sp(context)),
        ],
      ),
    );
  }
}
