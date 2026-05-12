import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

/// BLoC responsible for cart item management.
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    final updated = Map<int, CartItem>.from(state.items);
    final existing = updated[event.dishId];
    if (existing != null) {
      updated[event.dishId] = existing.copyWith(quantity: existing.quantity + 1);
    } else {
      updated[event.dishId] = CartItem(
        dishId: event.dishId,
        dishName: event.dishName,
        quantity: 1,
      );
    }
    emit(state.copyWith(items: updated));
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final updated = Map<int, CartItem>.from(state.items);
    final existing = updated[event.dishId];
    if (existing != null && existing.quantity > 0) {
      updated[event.dishId] =
          existing.copyWith(quantity: existing.quantity - 1);
      emit(state.copyWith(items: updated));
    }
  }
}
