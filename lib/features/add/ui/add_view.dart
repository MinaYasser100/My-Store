import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_store/core/utils/constant.dart';

const Color kPrimaryColor = Color(0xFF0D2857);
const Color kBg = Color(0xFFF7F9FC);

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  final _picker = ImagePicker();
  XFile? _image;
  bool _saving = false;

  final List<String> _categories = const [
    "women's clothing",
    "men's clothing",
    "jewelery",
    "electronics",
  ];
  String _selectedCategory = "women's clothing";

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 45,
      maxWidth: 400,
      maxHeight: 400,
    );
    if (picked != null) {
      setState(() => _image = picked);
    }
  }

  Future<void> _submit() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    FocusScope.of(context).unfocus();

    try {
      // 1. توليد ID كـ int فريد
      final int productId = DateTime.now().millisecondsSinceEpoch;

      // 2. تحويل الصورة إلى Base64 نقي (بدون الـ prefix)
      String? imageValue; // <-- متغير جديد عشان يحفظ الداتا أو الرابط
      if (_image != null) {
        final file = File(_image!.path);
        final Uint8List imageBytes = await file.readAsBytes();
        final String base64String = base64Encode(imageBytes);
        imageValue = base64String; // <-- بنحفظ النص النقي بس
      }

      final double price = double.tryParse(_priceCtrl.text.trim()) ?? 0.0;

      // 3. إنشاء الـ JSON مع id كـ int
      final Map<String, dynamic> product = {
        'id': productId, // int → يتوافق مع ProductModel.fromJson()
        'title': _nameCtrl.text.trim(),
        'price': price,
        'category': _selectedCategory,
        'description': _descriptionCtrl.text.trim(),
        'image': imageValue, // <-- استخدام المتغير الجديد
        'rating': {'rate': 0.0, 'count': 0},
        'createdAt': FieldValue.serverTimestamp(),
      };

      // 4. حفظ بـ set() مع document ID = productId كـ String
      await FirebaseFirestore.instance
          .collection(ConstantVariable.productsCollection)
          .doc(productId.toString()) // document ID = "1700000000000"
          .set(product);

      debugPrint('Product added with ID: $productId');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product added successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // إعادة تعيين النموذج
        _formKey.currentState!.reset();
        _nameCtrl.clear();
        _priceCtrl.clear();
        _descriptionCtrl.clear();
        setState(() {
          _image = null;
          _selectedCategory = _categories.first;
        });
      }
    } on FirebaseException catch (e) {
      debugPrint('Firestore Error: ${e.message}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: ${e.message ?? "Unknown error"}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An unexpected error occurred.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : kBg,
      appBar: AppBar(
        backgroundColor: isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.white,
        elevation: 0,
        title: Text(
          'Add Product',
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyLarge?.color ?? kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              _sectionCard(
                title: 'Product Image',
                child: Center(
                  child: InkWell(
                    onTap: _pickImage,
                    child: _image == null
                        ? Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1.2,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: kPrimaryColor,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(_image!.path),
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                title: 'Product Details',
                child: Column(
                  children: [
                    _LabeledField(
                      label: 'Product Name *',
                      child: TextFormField(
                        controller: _nameCtrl,
                        textInputAction: TextInputAction.next,
                        decoration: _inputDecoration(
                          hint: 'Enter product name',
                        ),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _LabeledField(
                      label: 'Price *',
                      child: TextFormField(
                        controller: _priceCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        textInputAction: TextInputAction.next,
                        decoration: _inputDecoration(
                          hint: '0.00',
                          suffix: 'LE',
                        ),
                        validator: (v) {
                          final s = v?.trim() ?? '';
                          if (s.isEmpty) return 'Required';
                          final d = double.tryParse(s);
                          if (d == null || d < 0) return 'Enter valid price';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    _LabeledField(
                      label: 'Category',
                      child: _CategoryDropdown(
                        value: _selectedCategory,
                        items: _categories,
                        onChanged: (val) {
                          if (val != null)
                            setState(() => _selectedCategory = val);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    _LabeledField(
                      label: 'Description',
                      child: TextFormField(
                        controller: _descriptionCtrl,
                        maxLines: 4,
                        textInputAction: TextInputAction.newline,
                        decoration: _inputDecoration(
                          hint: 'Describe your product...',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _saving ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _saving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Add Product',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).cardColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withAlpha(13),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: isDark
              ? Colors.grey[700] ?? const Color(0xFFE9EEF5)
              : const Color(0xFFE9EEF5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color:
                  Theme.of(context).textTheme.bodyLarge?.color ?? kPrimaryColor,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint, String? suffix}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InputDecoration(
      hintText: hint,
      suffixText: suffix,
      suffixStyle: TextStyle(
        color: isDark ? Colors.grey[400] : const Color(0xFF6B7280),
        fontWeight: FontWeight.w600,
      ),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      filled: true,
      fillColor: isDark ? Theme.of(context).cardColor : Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isDark
              ? Colors.grey[700] ?? const Color(0xFFE4E8EE)
              : const Color(0xFFE4E8EE),
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: kPrimaryColor, width: 1.4),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyLarge?.color ??
                const Color(0xFF374151),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _CategoryDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DropdownButtonFormField<String>(
      value: items.contains(value) ? value : items.first,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        filled: true,
        fillColor: isDark ? Theme.of(context).cardColor : Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDark
                ? Colors.grey[700] ?? const Color(0xFFE4E8EE)
                : const Color(0xFFE4E8EE),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.4),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      borderRadius: BorderRadius.circular(12),
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: kPrimaryColor),
    );
  }
}
