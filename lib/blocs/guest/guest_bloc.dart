import 'package:flutter_bloc/flutter_bloc.dart';
import 'guest_event.dart';
import 'guest_state.dart';
import '../../data/repositories/guest_repository.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  final GuestRepository repository;

  GuestBloc(this.repository) : super(GuestInitial()) {
    on<LoadGuestData>((event, emit) async {
      emit(GuestLoading());
      try {
        final categories = await repository.fetchCategories();
        final promotions = await repository.fetchPromotions();
        final products = await repository.fetchPopularItems();
        emit(GuestLoaded(categories: categories, promotions: promotions, products: products));
      } catch (e) {
        emit(GuestError(e.toString()));
      }
    });
  }
}
