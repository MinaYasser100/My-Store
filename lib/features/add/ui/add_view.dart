import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p; // استيراد مكتبة path

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
  final _supplierCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  final _picker = ImagePicker();
  XFile? _image;
  bool _saving = false;

  // --- التغيير: فئات الملابس ---
  final List<String> _categories = const [
    'T-shirts',
    'Pants',
    'Dresses',
    'Shoes',
    'Accessories',
    'Outerwear',
  ];
  String _selectedCategory = 'T-shirts'; // --- التغيير: الفئة الافتراضية ---

  // --- الحذف: تم إزالة متغيرات المعلومات الغذائية ---
  // bool _vegan = false;
  // bool _glutenFree = false;
  // bool _dairyFree = false;
  // bool _organic = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _supplierCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    // --- التعديل: إضافة تحديد للحجم الأقصى لتقليل حجم الصورة ---
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85, // ضغط الصورة بنسبة 85%
      maxWidth: 1024, // تحديد أقصى عرض
      maxHeight: 1024, // تحديد أقصى ارتفاع
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
      String? imageUrl;

      if (_image != null) {
        final file = File(_image!.path);
        final fileName = '${DateTime.now().millisecondsSinceEpoch}${p.extension(_image!.path)}';
        final ref = FirebaseStorage.instance.ref().child('product_images').child(fileName);

        final uploadTask = ref.putFile(file);
        final snapshot = await uploadTask.whenComplete(() => null);
        imageUrl = await snapshot.ref.getDownloadURL();
        debugPrint('Image uploaded successfully: $imageUrl');
      }

      final price = double.tryParse(_priceCtrl.text.trim()) ?? 0.0;
      final product = {
        'name': _nameCtrl.text.trim(),
        'price': price,
        'supplier': _supplierCtrl.text.trim(), // سيبقى اسم الحقل كما هو في الفايربيس
        'category': _selectedCategory,
        'description': _descriptionCtrl.text.trim(),
        // --- الحذف: تم إزالة كائن المعلومات الغذائية ---
        // 'dietary': { ... },
        'imageUrl': imageUrl,
        'imagePath': _image?.path,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance.collection('products').add(product);

      debugPrint('Product added to Firestore: $product');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product added successfully to Firebase!'),
            backgroundColor: Colors.green,
          ),
        );

        _formKey.currentState!.reset();
        setState(() {
          _image = null;
          _selectedCategory = _categories.first;
          // --- الحذف: تم إزالة إعادة تعيين المتغيرات الغذائية ---
          // _vegan = _glutenFree = _dairyFree = _organic = false;
          _priceCtrl.clear();
        });
      }
    } on FirebaseException catch (e) {
      debugPrint('Error uploading product: ${e.message}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add product: ${e.message ?? "Unknown error"}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint('An unexpected error occurred: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An unexpected error occurred. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (mounted) {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Add Product',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kPrimaryColor, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 12),
            child: Icon(Icons.search, color: kPrimaryColor, size: 22),
          ),
        ],
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
                // --- التغيير: تمت إضافة Center ---
                child: Center(
                  child: InkWell(
                    onTap: _pickImage,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      // --- التغيير: تم تعديل الحجم ---
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE4E8EE), width: 1.2),
                      ),
                      child: _image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add, size: 28, color: kPrimaryColor),
                                const SizedBox(height: 6),
                                Text(
                                  'Tap to upload image',
                                  style: t.bodyMedium?.copyWith(color: const Color(0xFF6B7280)),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'PNG, JPG up to 10MB',
                                  style: t.labelMedium?.copyWith(color: const Color(0xFF9CA3AF)),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(_image!.path),
                                width: double.infinity,
                                height: double.infinity,
                                // --- التغيير: عرض الصورة كاملة ---
                                fit: BoxFit.contain,
                              ),
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
                        decoration: _inputDecoration(hint: 'Enter product name'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _LabeledField(
                      label: 'Price *',
                      child: TextFormField(
                        controller: _priceCtrl,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textInputAction: TextInputAction.next,
                        decoration: _inputDecoration(hint: '0.00', suffix: 'LE'),
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
                      // --- التغيير: تم تغيير العنوان ---
                      label: 'Brand/Supplier *',
                      child: TextFormField(
                        controller: _supplierCtrl,
                        textInputAction: TextInputAction.next,
                        // --- التغيير: تم تغيير النص المؤقت ---
                        decoration: _inputDecoration(hint: 'Brand or supplier name'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _LabeledField(
                      label: 'Category',
                      child: _CategoryDropdown(
                        value: _selectedCategory,
                        items: _categories,
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedCategory = val);
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
                        decoration: _inputDecoration(hint: 'Describe your product...'),
                      ),
                    ),
                  ],
                ),
              ),
              // --- الحذف: تم إزالة كارت المعلومات الغذائية ---
              // const SizedBox(height: 16),
              // _sectionCard( ... dietary info ... ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _saving ? null : _submit,
                  child: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text(
                          'Add Product',
                          style: TextStyle(fontWeight: FontWeight.w600),
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
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withAlpha(13),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: const Color(0xFFE9EEF5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  // --- الحذف: تم إزالة ودجت _dietChip ---
  // Widget _dietChip(...) { ... }

  InputDecoration _inputDecoration({String? hint, String? suffix}) {
    return InputDecoration(
      hintText: hint,
      // --- التغيير: استخدام suffixText بدلاً من suffixIcon ---
      suffixText: suffix,
      suffixStyle: const TextStyle(
        color: Color(0xFF6B7280),
        fontWeight: FontWeight.w600,
      ),
      // --- الحذف: تمت إزالة suffixIcon و constraints ---
      // suffixIcon: suffix != null
      //     ? Padding(...)
      //     : null,
      // suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFE4E8EE), width: 1.2),
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
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: t.bodyMedium?.copyWith(
            color: const Color(0xFF374151),
            fontWeight: FontWeight.w600,
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
    return DropdownButtonFormField<String>(
      // --- التغيير: تم تحديث القيمة الأولية (لضمان التوافق مع التغييرات) ---
      // --- إصلاح: تم تغيير 'value' إلى 'initialValue' لمعالجة التحذير ---
      initialValue: items.contains(value) ? value : items.first,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE4E8EE), width: 1.2),
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