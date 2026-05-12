import 'package:equatable/equatable.dart';

/// Events for the Cart BLoC.
sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// Add one unit of a dish to the cart.
final class CartItemAdded extends CartEvent {
  final int dishId;
  final String dishName;

  const CartItemAdded({required this.dishId, required this.dishName});

  @override
  List<Object?> get props => [dishId, dishName];
}

/// Remove one unit of a dish from the cart.
final class CartItemRemoved extends CartEvent {
  final int dishId;

  const CartItemRemoved({required this.dishId});

  @override
  List<Object?> get props => [dishId];
}
