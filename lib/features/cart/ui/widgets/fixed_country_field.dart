import 'package:flutter/material.dart';

class FixedCountryField extends StatelessWidget {
  const FixedCountryField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: 'Egypt',
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Country",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
