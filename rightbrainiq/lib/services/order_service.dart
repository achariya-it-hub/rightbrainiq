import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class OrderService {
  static final OrderService instance = OrderService._();
  OrderService._();

  SupabaseClient get _client => SupabaseService.instance.client;

  Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    return _client.from('orders')
        .select('*, order_items(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);
  }

  Future<void> placeOrder({
    required String userId,
    required double total,
    required String paymentMethod,
    required String address,
    required String city,
    required String pincode,
    required String phone,
    required List<Map<String, dynamic>> items,
  }) async {
    final orderId = _client.from('orders').insert({
      'user_id': userId,
      'total': total,
      'payment_method': paymentMethod,
      'address': address,
      'city': city,
      'pincode': pincode,
      'phone': phone,
    }).select('id').single();

    for (final item in items) {
      await _client.from('order_items').insert({
        'order_id': orderId,
        'product_id': item['product_id'],
        'product_name': item['product_name'],
        'product_price': item['product_price'],
        'product_image': item['product_image'] ?? '',
        'quantity': item['quantity'],
      });
    }

    await _client.from('cart_items').delete().eq('user_id', userId);
  }
}
