import 'package:flutter/material.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/features/home/ui/widgets/categories_filter_bar.dart';
import 'package:my_store/features/home/ui/widgets/product_card_item.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key, required this.products});

  final List<ProductModel> products;

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  String? _selectedCategory;
  List<ProductModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _selectedCategory = 'All';
    _filteredProducts = widget.products;
  }

  @override
  void didUpdateWidget(ProductsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.products != widget.products) {
      _filterProducts();
    }
  }

  List<String> _extractCategories() {
    final categories = <String>{'All'};
    for (var product in widget.products) {
      if (product.category != null && product.category!.isNotEmpty) {
        categories.add(product.category!);
      }
    }
    return categories.toList();
  }

  void _filterProducts() {
    setState(() {
      if (_selectedCategory == null || _selectedCategory == 'All') {
        _filteredProducts = widget.products;
      } else {
        _filteredProducts = widget.products
            .where((product) => product.category == _selectedCategory)
            .toList();
      }
    });
  }

  void _onCategorySelected(String? category) {
    setState(() {
      _selectedCategory = category;
      _filterProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = _extractCategories();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          // First item is the categories bar
          if (index == 0) {
            return CategoriesFilterBar(
              categories: categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: _onCategorySelected,
            );
          }

          // Remaining items are products
          final productIndex = index - 1;
          return ProductCardItem(product: _filteredProducts[productIndex]);
        },
        childCount: _filteredProducts.length + 1, // +1 for categories bar
      ),
    );
  }
}
