import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class CartService {
  static final CartService instance = CartService._();
  CartService._();

  SupabaseClient get _client => SupabaseService.instance.client;

  Future<List<Map<String, dynamic>>> getCartItems(String userId) async {
    final data = await _client.from('cart_items')
        .select('*, products(*)')
        .eq('user_id', userId);
    return data;
  }

  Future<void> addToCart(String userId, String productId, {int quantity = 1}) async {
    final existing = await _client.from('cart_items')
        .select('id, quantity')
        .eq('user_id', userId)
        .eq('product_id', productId)
        .maybeSingle();

    if (existing != null) {
      await _client.from('cart_items')
          .update({'quantity': (existing['quantity'] as int) + quantity})
          .eq('id', existing['id'] as String);
    } else {
      await _client.from('cart_items').insert({
        'user_id': userId,
        'product_id': productId,
        'quantity': quantity,
      });
    }
  }

  Future<void> updateQuantity(String userId, String productId, int quantity) async {
    await _client.from('cart_items')
        .update({'quantity': quantity})
        .eq('user_id', userId)
        .eq('product_id', productId);
  }

  Future<void> removeFromCart(String userId, String productId) async {
    await _client.from('cart_items')
        .delete()
        .eq('user_id', userId)
        .eq('product_id', productId);
  }

  Future<void> clearCart(String userId) async {
    await _client.from('cart_items')
        .delete()
        .eq('user_id', userId);
  }
}
