part of 'login_cubit.dart';

class ResetPasswordSent extends SigninState {}

class SigninError extends SigninState {
  final String message;

  SigninError(this.message);
}

final class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

@immutable
sealed class SigninState {}

class UserNotVerified extends SigninState {}

class UserSignInSuccess extends SigninState {}
