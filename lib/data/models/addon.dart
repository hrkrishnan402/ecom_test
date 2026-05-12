import 'package:equatable/equatable.dart';

/// An optional add-on for a dish (e.g. "Extra Dressing").
class Addon extends Equatable {
  final int id;
  final String name;
  final String price;

  const Addon({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name, price];
}
