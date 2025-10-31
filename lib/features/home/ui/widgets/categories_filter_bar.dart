import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_style.dart';

class CategoriesFilterBar extends StatelessWidget {
  const CategoriesFilterBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<String> categories;
  final String? selectedCategory;
  final Function(String?) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                category == 'All' ? 'All Products' : category,
                style: AppTextStyles.styleMedium14sp(context).copyWith(
                  color: isSelected
                      ? Colors.white
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                onCategorySelected(selected ? category : 'All');
              },
              backgroundColor: isDark ? theme.cardColor : Colors.grey[200],
              selectedColor: theme.primaryColor,
              checkmarkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? theme.primaryColor
                      : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        },
      ),
    );
  }
}
