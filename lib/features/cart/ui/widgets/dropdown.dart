import 'package:flutter/material.dart';

class ItemQuantityDropdown extends StatefulWidget {
  const ItemQuantityDropdown({super.key});

  @override
  State<ItemQuantityDropdown> createState() => _ItemQuantityDropdownState();
}

class _ItemQuantityDropdownState extends State<ItemQuantityDropdown> {
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedQuantity,
      menuMaxHeight: 250,
      items: List<int>.generate(10, (i) => i + 1)
          .map((qty) => DropdownMenuItem(value: qty, child: Text('$qty')))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => selectedQuantity = value);
        }
      },
    );
  }
}
