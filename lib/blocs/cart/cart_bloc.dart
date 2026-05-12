import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

/// BLoC responsible for cart item management.
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartClearRequested>(_onClearRequested);
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    final updated = Map<int, CartItem>.from(state.items);
    final existing = updated[event.dish.id];
    if (existing != null) {
      updated[event.dish.id] =
          existing.copyWith(quantity: existing.quantity + 1);
    } else {
      updated[event.dish.id] = CartItem(
        dish: event.dish,
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

  void _onClearRequested(CartClearRequested event, Emitter<CartState> emit) {
    emit(const CartState());
  }
}
