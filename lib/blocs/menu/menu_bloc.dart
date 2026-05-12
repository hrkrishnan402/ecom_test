import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/menu_repository.dart';
import 'menu_event.dart';
import 'menu_state.dart';

/// BLoC responsible for fetching and exposing menu categories.
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository _repository;

  MenuBloc({required MenuRepository repository})
      : _repository = repository,
        super(const MenuInitial()) {
    on<MenuFetchRequested>(_onFetchRequested);
  }

  Future<void> _onFetchRequested(
    MenuFetchRequested event,
    Emitter<MenuState> emit,
  ) async {
    emit(const MenuLoading());
    try {
      final categories = await _repository.fetchMenu();
      emit(MenuLoaded(categories: categories));
    } catch (e) {
      emit(MenuError(message: e.toString()));
    }
  }
}
