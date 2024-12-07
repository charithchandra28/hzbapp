import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/promotion_model.dart';

abstract class GuestState {}

class GuestInitial extends GuestState {}

class GuestLoading extends GuestState {}

class GuestLoaded extends GuestState {
  final List<Category> categories;
  final List<Product> products;
  final List<Promotion> promotions;

  GuestLoaded({required this.categories, required this.products, required this.promotions});
}

class GuestError extends GuestState {
  final String message;

  GuestError(this.message);
}
