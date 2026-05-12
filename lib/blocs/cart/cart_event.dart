import 'package:equatable/equatable.dart';
import '../../data/models/dish.dart';

/// Events for the Cart BLoC.
sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// Add one unit of a dish to the cart.
final class CartItemAdded extends CartEvent {
  final Dish dish;

  const CartItemAdded({required this.dish});

  @override
  List<Object?> get props => [dish];
}

/// Remove one unit of a dish from the cart.
final class CartItemRemoved extends CartEvent {
  final int dishId;

  const CartItemRemoved({required this.dishId});

  @override
  List<Object?> get props => [dishId];
}

/// Clear the entire cart.
final class CartClearRequested extends CartEvent {
  const CartClearRequested();
}
