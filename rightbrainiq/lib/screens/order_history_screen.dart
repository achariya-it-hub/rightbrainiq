import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/order_history_state.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../widgets/product_image.dart';

class OrderHistoryScreen extends StatelessWidget {
  final OrderHistoryState orderHistoryState;

  const OrderHistoryScreen({super.key, required this.orderHistoryState});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Orders'),
      ),
      body: ListenableBuilder(
        listenable: orderHistoryState,
        builder: (context, _) {
          final orders = orderHistoryState.orders;
          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_outlined, size: 64, color: scheme.onSurface.withValues(alpha: 0.15)),
                  const SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: scheme.onSurface.withValues(alpha: 0.5)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your completed orders will appear here',
                    style: TextStyle(fontSize: 13, color: scheme.onSurface.withValues(alpha: 0.35)),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: orders.length,
            itemBuilder: (context, index) => _OrderCard(order: orders[index]),
          );
        },
      ),
    );
  }
}

class _OrderCard extends StatefulWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  State<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final scheme = Theme.of(context).colorScheme;
    final itemCount = order.items.fold<int>(0, (sum, item) => sum + item.quantity);
    final color = Color(order.items.first.product.color.hexValue);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.receipt, color: color, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Order #${order.id}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: scheme.onSurface)),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(order.status, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.success)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${order.date.day}/${order.date.month}/${order.date.year} • $itemCount item${itemCount > 1 ? 's' : ''}',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '₹${order.total.round()} • ${order.paymentMethod}',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: scheme.onSurface),
                        ),
                      ],
                    ),
                  ),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more, color: AppColors.textSecondary),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.15)),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Details', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: scheme.onSurface)),
                  const SizedBox(height: 8),
                  ...order.items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 40, height: 40,
                            child: ProductImage(
                              imageUrl: item.product.imageUrl,
                              fit: BoxFit.cover,
                              color: Color(item.product.color.hexValue),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.product.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                              Text('Qty: ${item.quantity}', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        Text('₹${item.totalPrice.round()}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  )),
                  const SizedBox(height: 4),
                  Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.15)),
                  const SizedBox(height: 8),
                  Text('Delivery Address', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: scheme.onSurface)),
                  const SizedBox(height: 4),
                  Text(
                    '${order.address}, ${order.city} - ${order.pincode}',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Phone: ${order.phone}',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
