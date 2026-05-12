import 'package:equatable/equatable.dart';
import '../../data/models/dish.dart';

/// Represents a single cart entry.
class CartItem extends Equatable {
  final Dish dish;
  final int quantity;

  const CartItem({
    required this.dish,
    this.quantity = 0,
  });

  CartItem copyWith({int? quantity}) => CartItem(
        dish: dish,
        quantity: quantity ?? this.quantity,
      );

  @override
  List<Object?> get props => [dish, quantity];
}

/// State for the Cart BLoC.
class CartState extends Equatable {
  /// Map of dishId → CartItem.
  final Map<int, CartItem> items;

  const CartState({this.items = const {}});

  /// Total number of items across all dishes.
  int get totalQuantity =>
      items.values.fold(0, (sum, item) => sum + item.quantity);

  /// Total price of all items in the cart.
  double get totalPrice => items.values.fold(
      0.0,
      (sum, item) =>
          sum + (double.tryParse(item.dish.price) ?? 0.0) * item.quantity);

  /// Quantity for a specific dish.
  int quantityOf(int dishId) => items[dishId]?.quantity ?? 0;

  /// Non-empty cart entries for display.
  List<CartItem> get nonEmptyItems =>
      items.values.where((item) => item.quantity > 0).toList();

  CartState copyWith({Map<int, CartItem>? items}) =>
      CartState(items: items ?? this.items);

  @override
  List<Object?> get props => [items];
}
