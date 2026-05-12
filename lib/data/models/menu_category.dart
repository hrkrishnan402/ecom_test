import 'package:equatable/equatable.dart';

import 'dish.dart';

/// A top-level menu category (e.g. "Salads and Soup").
class MenuCategory extends Equatable {
  final int id;
  final String name;
  final List<Dish> dishes;

  const MenuCategory({
    required this.id,
    required this.name,
    required this.dishes,
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      dishes: (json['dishes'] as List<dynamic>)
          .map((d) => Dish.fromJson(d as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, dishes];
}
