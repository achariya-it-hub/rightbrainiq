import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.dart';
import '../models/category.dart';
import 'supabase_service.dart';

class ProductService {
  static final ProductService instance = ProductService._();
  ProductService._();

  SupabaseClient get _client => SupabaseService.instance.client;

  Future<List<Category>> getCategories() async {
    final data = await _client.from('categories').select('*').order('id');
    return data.map((json) => Category(
      name: json['name'] as String,
      slug: json['slug'] as String,
      productCount: json['product_count'] as int,
      imageUrl: json['image_url'] as String,
      description: json['description'] as String? ?? '',
    )).toList();
  }

  Future<List<Product>> getAllProducts() async {
    final data = await _client.from('products').select('*').order('id');
    return data.map(_productFromJson).toList();
  }

  Future<List<Product>> getProductsByCategory(String categorySlug) async {
    final data = await _client.from('products')
        .select('*')
        .eq('category_slug', categorySlug)
        .order('id');
    return data.map(_productFromJson).toList();
  }

  Future<Product?> getProductById(String id) async {
    final data = await _client.from('products').select('*').eq('id', id).maybeSingle();
    if (data == null) return null;
    return _productFromJson(data);
  }

  Product _productFromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category_slug'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? '₹',
      imageUrl: json['image_url'] as String,
      imageUrl2: json['image_url2'] as String?,
      cardCount: json['card_count'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      color: _parseColor(json['color'] as String? ?? 'blue'),
    );
  }

  ColorCode _parseColor(String color) {
    switch (color) {
      case 'red': return ColorCode.red;
      case 'orange': return ColorCode.orange;
      case 'yellow': return ColorCode.yellow;
      case 'green': return ColorCode.green;
      case 'teal': return ColorCode.teal;
      case 'blue': return ColorCode.blue;
      case 'purple': return ColorCode.purple;
      case 'pink': return ColorCode.pink;
      case 'indigo': return ColorCode.indigo;
      default: return ColorCode.blue;
    }
  }
}
