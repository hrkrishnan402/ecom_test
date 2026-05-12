import 'package:equatable/equatable.dart';

import 'addon.dart';

class Dish extends Equatable {
  final int id;
  final String name;
  final String price;
  final String currency;
  final int calories;
  final String description;
  final List<Addon> addons;
  final String imageUrl;
  final bool customizationsAvailable;
  final bool isVeg;

  const Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.calories,
    required this.description,
    required this.addons,
    required this.imageUrl,
    required this.customizationsAvailable,
    required this.isVeg,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as String,
      currency: json['currency'] as String? ?? 'INR',
      calories: json['calories'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      addons: (json['addons'] as List<dynamic>?)
              ?.map((a) => Addon.fromJson(a as Map<String, dynamic>))
              .toList() ??
          const [],
      imageUrl: json['image_url'] as String? ?? '',
      customizationsAvailable:
          (json['addoncat'] as List<dynamic>?)?.isNotEmpty ?? false,
      isVeg: json['is_veg'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        currency,
        calories,
        description,
        addons,
        imageUrl,
        customizationsAvailable,
        isVeg,
      ];
}
