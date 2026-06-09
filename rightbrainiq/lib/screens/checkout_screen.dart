import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../state/cart_state.dart';
import '../state/profile_state.dart';
import '../state/order_history_state.dart';
import '../widgets/product_image.dart';
import '../services/cashfree_service.dart';

class CheckoutScreen extends StatefulWidget {
  final CartState cartState;
  final ProfileState? profileState;
  final OrderHistoryState orderHistoryState;

  const CheckoutScreen({
    super.key,
    required this.cartState,
    this.profileState,
    required this.orderHistoryState,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPayment = 0;
  bool _loading = false;
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _phoneController = TextEditingController();

  final _paymentMethods = [
    {'name': 'UPI', 'icon': Icons.qr_code_scanner},
    {'name': 'Credit / Debit Card', 'icon': Icons.credit_card},
    {'name': 'Cash on Delivery', 'icon': Icons.money},
  ];

  @override
  void initState() {
    super.initState();
    final profile = widget.profileState?.profile;
    _phoneController.text = profile?.phone ?? '';
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    if (_addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your delivery address'), behavior: SnackBarBehavior.floating),
      );
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number'), behavior: SnackBarBehavior.floating),
      );
      return;
    }

    final isCOD = _selectedPayment == 2;
    if (isCOD) {
      _completeOrder('Cash on Delivery');
      return;
    }

    if (!CashfreeService.isConfigured) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Online payment not configured. Please use Cash on Delivery.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _loading = true);

    final cartItems = widget.cartState.items;
    final delivery = cartItems.length > 1 ? 49.0 : 0.0;
    final orderTotal = widget.cartState.totalPrice + delivery;

    CashfreeService.createOrder(
      amount: orderTotal,
      customerPhone: _phoneController.text.trim(),
    ).then((paymentSessionId) {
      if (!mounted) return;
      if (paymentSessionId == null) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to initiate payment'), behavior: SnackBarBehavior.floating),
        );
        return;
      }

      final orderId = 'RB_${DateTime.now().millisecondsSinceEpoch}';
      CashfreeService.startPayment(
        orderId: orderId,
        paymentSessionId: paymentSessionId,
        onSuccess: () {
          if (!mounted) return;
          setState(() => _loading = false);
          _completeOrder(_paymentMethods[_selectedPayment]['name'] as String);
        },
        onError: () {
          if (!mounted) return;
          setState(() => _loading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment failed'), behavior: SnackBarBehavior.floating),
          );
        },
      );
    });
  }

  void _completeOrder(String paymentMethod) {
    final cartItems = widget.cartState.items;
    final delivery = cartItems.length > 1 ? 49.0 : 0.0;
    final orderTotal = widget.cartState.totalPrice + delivery;
    final orderId = DateTime.now().millisecondsSinceEpoch.toString().substring(7);
    widget.orderHistoryState.addOrder(Order(
      id: orderId,
      items: cartItems.map((i) => i.copyWith()).toList(),
      total: orderTotal,
      paymentMethod: paymentMethod,
      address: _addressController.text.trim(),
      city: _cityController.text.trim(),
      pincode: _pincodeController.text.trim(),
      phone: _phoneController.text.trim(),
      date: DateTime.now(),
    ));
    widget.cartState.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: AppColors.success, size: 48),
            ),
            const SizedBox(height: 16),
            const Text('Order Placed!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              'Your order has been placed successfully.\nPayment method: $paymentMethod',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Continue Shopping', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: widget.cartState,
      builder: (context, _) {
        final items = widget.cartState.items;
        if (items.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.of(context).popUntil((route) => route.isFirst));
          return const SizedBox.shrink();
        }

        final delivery = items.length > 1 ? 49.0 : 0.0;
        final subtotal = widget.cartState.totalPrice;
        final total = subtotal + delivery;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Checkout'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  children: [
                    _sectionHeader('Delivery Address'),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              hintText: 'Street, area, landmark',
                              labelText: 'Address',
                              prefixIcon: const Icon(Icons.location_on_outlined, size: 20),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                    hintText: 'City',
                                    prefixIcon: const Icon(Icons.location_city, size: 20),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _pincodeController,
                                  decoration: InputDecoration(
                                    hintText: 'Pincode',
                                    prefixIcon: const Icon(Icons.pin_drop, size: 20),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              hintText: 'Phone number',
                              labelText: 'Phone',
                              prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionHeader('Payment Method'),
                    const SizedBox(height: 10),
                    ...List.generate(_paymentMethods.length, (i) {
                      final method = _paymentMethods[i];
                      final selected = _selectedPayment == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedPayment = i),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.primary.withValues(alpha: 0.06) : scheme.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected ? AppColors.primary : scheme.outlineVariant.withValues(alpha: 0.3),
                              width: selected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(method['icon'] as IconData, size: 24,
                                color: selected ? AppColors.primary : AppColors.textSecondary),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(method['name'] as String,
                                  style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600,
                                    color: selected ? AppColors.primary : scheme.onSurface,
                                  ),
                                ),
                              ),
                              Container(
                                width: 22, height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selected ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.4),
                                    width: selected ? 2 : 1.5,
                                  ),
                                  color: selected ? AppColors.primary : Colors.transparent,
                                ),
                                child: selected
                                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    _sectionHeader('Order Summary'),
                    const SizedBox(height: 10),
                    ...items.map((item) => _orderItemCard(context, item)),
                  ],
                ),
              ),
              _bottomBar(context, subtotal, delivery, total),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionHeader(String title) {
    return Text(title, style: TextStyle(
      fontSize: 16, fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.onSurface,
    ));
  }

  Widget _orderItemCard(BuildContext context, CartItem item) {
    final color = Color(item.product.color.hexValue);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 56, height: 56,
              child: ProductImage(imageUrl: item.product.imageUrl, fit: BoxFit.cover, color: color),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('Qty: ${item.quantity}', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text('${item.product.currency}${item.product.price}', style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }

  Widget _bottomBar(BuildContext context, double subtotal, double delivery, double total) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: scheme.surface,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _priceRow('Subtotal', '₹${subtotal.round()}', AppColors.textSecondary),
            if (delivery > 0) _priceRow('Delivery', '₹${delivery.round()}', AppColors.textSecondary),
            const Divider(height: 20),
            _priceRow('Total', '₹${total.round()}', null),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _loading ? null : _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: _loading
                    ? const SizedBox(
                        width: 22, height: 22,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                      )
                    : Text('Place Order • ₹${total.round()}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value, Color? color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: color ?? Theme.of(context).colorScheme.onSurface)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color ?? Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }
}
