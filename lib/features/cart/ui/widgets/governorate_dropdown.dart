import 'package:flutter/material.dart';

class GovernorateDropdown extends StatelessWidget {
  const GovernorateDropdown({super.key, required this.onChanged});

  final ValueChanged<String?> onChanged;

  final List<String> governorates = const [
    'Cairo',
    'Giza',
    'Alexandria',
    'Sharqia',
    'Dakahlia',
    'Menoufia',
    'Qalyubia',
    'Beheira',
    'Kafr El Sheikh',
    'Gharbia',
    'Sohag',
    'Minya',
    'Assiut',
    'Luxor',
    'fayoum'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      menuMaxHeight: 200,
      decoration: InputDecoration(
        labelText: "Governorate",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      validator: (v) =>
          v == null || v.isEmpty ? "Please select your governorate" : null,
      items: governorates
          .map((gov) => DropdownMenuItem(value: gov, child: Text(gov)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
