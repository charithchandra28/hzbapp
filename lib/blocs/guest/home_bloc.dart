import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../data/repositories/supabase_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SupabaseRepository repository;
  int currentPage = 0; // Current page for pagination

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final categories = await repository.fetchCategories();
        final promotions = await repository.fetchPromotions();
        final products = await repository.fetchProducts(page: 0);
        currentPage = 1;
        emit(HomeLoaded(categories, promotions, products));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<LoadMoreProducts>((event, emit) async {
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(HomeLoaded(
          currentState.categories,
          currentState.promotions,
          currentState.products,
          isLoadingMore: true,
        ));

        try {
          final newProducts = await repository.fetchProducts(page: currentPage);
          currentPage++;
          emit(HomeLoaded(
            currentState.categories,
            currentState.promotions,
            currentState.products + newProducts,
          ));
        } catch (e) {
          emit(HomeError(e.toString()));
        }
      }
    });
  }
}
