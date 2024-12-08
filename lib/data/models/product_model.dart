class Product {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final double? originalPrice; // Original price before discount (nullable)
  final double? discount; // Discount percentage (nullable)
  final double rating; // Average rating
  final int reviewCount; // Number of reviews
  final int stock; // Stock quantity
  final int categoryId; // Category ID

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    this.discount,
    required this.rating,
    required this.reviewCount,
    required this.stock,
    required this.categoryId,
  });

  // Factory constructor to create a Product instance from a JSON object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      price: json['price'].toDouble(),
      originalPrice: json['original_price']?.toDouble(),
      discount: json['discount']?.toDouble(),
      rating: json['rating'].toDouble(),
      reviewCount: json['review_count'],
      stock: json['stock'],
      categoryId: json['category_id'],
    );
  }

  // Convert a Product instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'price': price,
      'original_price': originalPrice,
      'discount': discount,
      'rating': rating,
      'review_count': reviewCount,
      'stock': stock,
      'category_id': categoryId,
    };
  }
}
