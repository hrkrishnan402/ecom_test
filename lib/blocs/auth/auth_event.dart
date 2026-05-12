import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthSignedOut extends AuthEvent {}

class AuthEmailSignInRequested extends AuthEvent {
  final String email;
  final String password;
  final bool isRegistration;

  const AuthEmailSignInRequested({
    required this.email,
    required this.password,
    this.isRegistration = false,
  });

  @override
  List<Object?> get props => [email, password, isRegistration];
}

class AuthPhoneSignInRequested extends AuthEvent {
  final String verificationId;
  final String smsCode;

  const AuthPhoneSignInRequested({
    required this.verificationId,
    required this.smsCode,
  });

  @override
  List<Object?> get props => [verificationId, smsCode];
}
class AuthGoogleSignInRequested extends AuthEvent {}
