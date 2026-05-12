import 'package:equatable/equatable.dart';

/// Events for the Menu BLoC.
sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object?> get props => [];
}

/// Triggers initial menu fetch from the API.
final class MenuFetchRequested extends MenuEvent {
  const MenuFetchRequested();
}
