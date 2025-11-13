import 'package:flutter/material.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/widgets/product_image.dart'; // <-- 1. إضافة الإمبورت

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 350,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: isDark ? ColorsTheme().secondaryColor : ColorsTheme().whiteColor,
      // --- 2. تم استبدال الكود القديم بالكود الجديد ---
      child: ProductImageWidget(
        imageString: imageUrl,
        fit: BoxFit.contain, // <-- استخدمنا نفس الـ fit الأصلي
        borderRadius: 0, // <-- مش محتاجين radius هنا
        // ملحوظة: مش هنبعت width أو height عشان الـ Widget ياخد حجم الـ Container
      ),
      // ------------------------------------------
    );
  }

  // --- 3. تم حذف دالة _buildErrorImage() لإننا مش محتاجينها ---
}