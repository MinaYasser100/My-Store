import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/theme/app_style.dart';
import 'package:my_store/core/utils/colors.dart';

class AddToBasketSection extends StatefulWidget {
  const AddToBasketSection({super.key, required this.product});

  final ProductModel product;

  @override
  State<AddToBasketSection> createState() => _AddToBasketSectionState();
}

class _AddToBasketSectionState extends State<AddToBasketSection> {
  int _quantity = 1;

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
    // TODO: Implement add to basket logic
    debugPrint('Adding ${widget.product.title} - Quantity: $_quantity');

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $_quantity item(s) to basket'),
        backgroundColor: ColorsTheme().primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            _buildQuantitySelector(),
            const SizedBox(width: 16),
            Expanded(child: _buildAddToBasketButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 20),
            onPressed: _decrementQuantity,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '$_quantity',
              style: AppTextStyles.styleBold16sp(
                context,
              ).copyWith(fontSize: 18),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 20),
            onPressed: _incrementQuantity,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToBasketButton() {
    return ElevatedButton(
      onPressed: _addToBasket,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsTheme().primaryDark,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add to basket',
            style: AppTextStyles.styleBold16sp(
              context,
            ).copyWith(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, size: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
