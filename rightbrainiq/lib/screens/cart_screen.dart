import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../state/cart_state.dart';
import '../state/profile_state.dart';
import '../state/order_history_state.dart';
import '../widgets/product_image.dart';
import 'product_detail_screen.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final CartState cartState;
  final ProfileState? profileState;
  final OrderHistoryState orderHistoryState;

  const CartScreen({super.key, required this.cartState, this.profileState, required this.orderHistoryState});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    widget.cartState.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    widget.cartState.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.cartState.items;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Cart'),
        actions: [
          if (items.isNotEmpty)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Clear Cart'),
                    content: const Text('Remove all items from cart?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                      TextButton(
                        onPressed: () {
                          widget.cartState.clear();
                          Navigator.pop(ctx);
                        },
                        child: const Text('Clear', style: TextStyle(color: AppColors.error)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Clear', style: TextStyle(color: AppColors.error)),
            ),
        ],
      ),
      body: items.isEmpty ? _emptyState(context) : _cartContent(context, items),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 64, color: AppColors.textSecondary.withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textSecondary.withValues(alpha: 0.5)),
          ),
          const SizedBox(height: 8),
          Text(
            'Browse products and add items to cart',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary.withValues(alpha: 0.35)),
          ),
        ],
      ),
    );
  }

  Widget _cartContent(BuildContext context, List<CartItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return _checkoutSection(context, items);
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _cartItemCard(context, items[index]),
        );
      },
    );
  }

  Widget _checkoutSection(BuildContext context, List<CartItem> items) {
    final total = widget.cartState.totalPrice;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
              Text('₹${total.round()}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: scheme.onSurface)),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(
                      cartState: widget.cartState,
                      profileState: widget.profileState,
                      orderHistoryState: widget.orderHistoryState,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.bolt),
              label: Text('Checkout • ${items.length}', style: const TextStyle(fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartItemCard(BuildContext context, CartItem item) {
    final color = Color(item.product.color.hexValue);
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: item.product))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 72, height: 72,
                      child: ProductImage(imageUrl: item.product.imageUrl, fit: BoxFit.cover, color: color),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: item.product))),
                        child: Text(
                          item.product.name,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${item.product.cardCount} cards',
                        style: TextStyle(fontSize: 11, color: AppColors.textSecondary.withValues(alpha: 0.6)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${item.product.currency}${item.product.price}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _qtyButton(Icons.remove, () => widget.cartState.updateQuantity(item.product.id, item.quantity - 1), color),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text('${item.quantity}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: color)),
                          ),
                          _qtyButton(Icons.add, () => widget.cartState.updateQuantity(item.product.id, item.quantity + 1), color),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => widget.cartState.removeItem(item.product.id),
                      child: Icon(Icons.delete_outline, size: 18, color: AppColors.error.withValues(alpha: 0.5)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _cartItemBottomBar(context, item, color),
        ],
      ),
    );
  }

  Widget _cartItemBottomBar(BuildContext context, CartItem item, Color color) {
    final total = item.totalPrice;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.15))),
      ),
      child: Row(
        children: [
          Text(
            'Subtotal',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withValues(alpha: 0.6)),
          ),
          const Spacer(),
          Text(
            '${item.product.currency}${total.toStringAsFixed(0)}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: color),
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}
