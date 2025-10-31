import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/features/cart/logic/cart_cubit.dart';

class ItemQuantityDropdown extends StatefulWidget {
  final int initialQuantity;
  final String itemId;
  const ItemQuantityDropdown({
    super.key,
    required this.initialQuantity,
    required this.itemId,
  });

  @override
  State<ItemQuantityDropdown> createState() => _ItemQuantityDropdownState();
}

class _ItemQuantityDropdownState extends State<ItemQuantityDropdown> {
  late int selectedQuantity;

  @override
  void initState() {
    super.initState();
    selectedQuantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedQuantity,
      menuMaxHeight: 250,
      items: List<int>.generate(11, (i) => i) // 0 to 10
          .map(
            (qty) => DropdownMenuItem(
              value: qty,
              child: Text('$qty'),
            ),
          )
          .toList(),
      onChanged: (value) async {
        if (value != null) {
          setState(() => selectedQuantity = value);
          final cubit = context.read<CartCubit>();
          if (value == 0) {
            await cubit.repo.deleteFromCart(cubit.userId, widget.itemId);
          } else {
            await cubit.changeQuantity(widget.itemId, value);
          }
        }
      },
    );
  }
}
