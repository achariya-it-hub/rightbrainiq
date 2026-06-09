import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final String? imageUrl2;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;
  final double borderRadius;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.imageUrl2,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    this.color,
    this.borderRadius = 0,
  });

  String _assetPath(String url) {
    final filename = url.split('/').last;
    return 'assets/images/products/$filename';
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        _assetPath(imageUrl),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error2, stackTrace2) => Container(
            width: width,
            height: height,
            color: (color ?? Colors.grey).withValues(alpha: 0.1),
            child: Icon(Icons.image, color: (color ?? Colors.grey).withValues(alpha: 0.3), size: 28),
          ),
        ),
      ),
    );
  }
}

class ProductImageSmall extends StatelessWidget {
  final String imageUrl;
  final double size;
  final Color? color;

  const ProductImageSmall({super.key, required this.imageUrl, this.size = 48, this.color});

  String _assetPath(String url) {
    final filename = url.split('/').last;
    return 'assets/images/products/$filename';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: (color ?? Colors.grey).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset(
          _assetPath(imageUrl),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error2, stackTrace2) => Icon(
              Icons.image,
              color: (color ?? Colors.grey).withValues(alpha: 0.3),
              size: size * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

extension ImageUrlToAsset on String {
  String get toAssetPath {
    final filename = split('/').last;
    return 'assets/images/products/$filename';
  }
}
