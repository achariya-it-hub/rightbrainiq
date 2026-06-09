import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/product.dart';
import '../state/cart_state.dart';
import '../widgets/product_image.dart';
import '../widgets/animated_price.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final CartState? cartState;
  final VoidCallback? onNavigateCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    this.cartState,
    this.onNavigateCart,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(product.color.hexValue);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          ListenableBuilder(
            listenable: cartState ?? CartState(),
            builder: (context, _) => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: onNavigateCart,
                ),
                if (cartState != null && cartState!.itemCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cartState!.itemCount}',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: color.withValues(alpha: 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: 280,
                    child: Stack(
                      children: [
                        Center(
                        child: Hero(
                          tag: 'product_img_${product.id}',
                          child: ProductImage(
                            imageUrl: product.imageUrl,
                            width: 240,
                            height: 240,
                            fit: BoxFit.contain,
                            color: color,
                            borderRadius: 20,
                          ),
                        ),
                        ),
                        if (product.imageUrl2 != null)
                          Positioned(
                            right: 20,
                            bottom: 10,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: ProductImage(
                                imageUrl: product.imageUrl2!,
                                fit: BoxFit.cover,
                                borderRadius: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                            ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                product.category,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AnimatedPrice(
                            price: product.price,
                            currency: product.currency,
                            cardCount: product.cardCount,
                            fontSize: 28,
                            color: color,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${product.cardCount} cards',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child:                       ElevatedButton.icon(
                        onPressed: () {
                          if (cartState != null) {
                            cartState!.addItem(product);
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                              ),
                              builder: (ctx) => Padding(
                                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: AppColors.success.withValues(alpha: 0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.check_circle, color: AppColors.success, size: 40),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text('Added to Cart!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${product.name} has been added to your cart.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () => Navigator.pop(ctx),
                                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                                            child: const Text('OK'),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(ctx);
                                              onNavigateCart?.call();
                                            },
                                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
                                            child: const Text('View Cart'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text('Add to Cart'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  const Text(
                    'About this pack',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description.isNotEmpty
                        ? product.description
                        : 'High-quality educational flash cards designed for right brain stimulation and early childhood development. Perfect for building vocabulary, memory, and cognitive skills.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: AppColors.textSecondary.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _infoChip(Icons.style, '${product.cardCount} Cards'),
                      const SizedBox(width: 12),
                      _infoChip(Icons.wifi_tethering, 'Right Brain Stimulus'),
                      const SizedBox(width: 12),
                      _infoChip(Icons.recycling, 'Eco-Friendly'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
