import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart'; // <-- تم تصحيح الخطأ هنا

class ProductImageWidget extends StatelessWidget {
  final String? imageString;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;

  const ProductImageWidget({
    super.key,
    required this.imageString,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.fill,
    this.borderRadius = 12.0, // Default border radius
  });

  // Placeholder widget
  Widget get _placeholder => Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: Icon(
          Icons.image_not_supported,
          color: Colors.grey[600],
          size: 40,
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageString == null || imageString!.isEmpty) {
      imageWidget = _placeholder;
    } else if (imageString!.startsWith('http')) {
      // 1. It's a URL (from fakestoreapi)
      imageWidget = Image.network(
        imageString!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _placeholder,
      );
    } else {
      // 2. Assume it's a Base64 string (from AddView)
      try {
        final Uint8List imageBytes = base64Decode(imageString!);
        imageWidget = Image.memory(
          imageBytes,
          width: width,
          height: height,
          fit: fit,
        );
      } catch (e) {
        // If decoding fails, show placeholder
        debugPrint('Failed to decode Base64 image: $e');
        imageWidget = _placeholder;
      }
    }

    // Apply border radius
    if (borderRadius > 0) {
      // Apply rectangular border radius
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: imageWidget,
      );
    } else {
      // No border radius
      return imageWidget;
    }
  }
}