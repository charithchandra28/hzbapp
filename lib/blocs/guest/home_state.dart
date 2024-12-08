import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/promotion_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Category> categories;
  final List<Promotion> promotions;
  final List<Product> products;
  final bool isLoadingMore;

  HomeLoaded(this.categories, this.promotions, this.products, {this.isLoadingMore = false});
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
