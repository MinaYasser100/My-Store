import 'package:flutter/material.dart';
import 'package:my_store/core/utils/colors.dart';

class LayoutNavIcon extends StatelessWidget {
  const LayoutNavIcon({
    super.key,
    required this.iconData,
    required this.label,
    required this.isSelected,
    this.activeIconData,
  });

  final IconData iconData;
  final IconData? activeIconData;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final iconColor = ColorsTheme().primaryDark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isSelected ? (activeIconData ?? iconData) : iconData,
          color: iconColor,
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: iconColor, fontSize: 12)),
        const SizedBox(height: 6),
        Container(
          height: 3,
          width: 30,
          decoration: BoxDecoration(
            color: isSelected ? iconColor : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
