import 'package:equatable/equatable.dart';

import '../../data/models/menu_category.dart';

/// States for the Menu BLoC.
sealed class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any fetch.
final class MenuInitial extends MenuState {
  const MenuInitial();
}

/// Loading indicator while fetching.
final class MenuLoading extends MenuState {
  const MenuLoading();
}

/// Successfully loaded menu categories.
final class MenuLoaded extends MenuState {
  final List<MenuCategory> categories;

  const MenuLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}

/// An error occurred during fetch.
final class MenuError extends MenuState {
  final String message;

  const MenuError({required this.message});

  @override
  List<Object?> get props => [message];
}
