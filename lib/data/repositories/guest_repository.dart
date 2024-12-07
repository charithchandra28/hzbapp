import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/promotion_model.dart';

class GuestRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  /// Fetches categories from the `categories` table.
  Future<List<Category>> fetchCategories() async {
    try {
      final data = await supabase.from('categories').select() as List<dynamic>;
      return data.map((json) => Category.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  /// Fetches popular products from the `products` table.
  Future<List<Product>> fetchPopularItems() async {
    try {
      final data = await supabase.from('products').select() as List<dynamic>;
      return data.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  /// Fetches promotions from the `promotions` table.
  Future<List<Promotion>> fetchPromotions() async {
    try {
      final data = await supabase.from('promotions').select() as List<dynamic>;
      return data.map((json) => Promotion.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch promotions: $e');
    }
  }
}
