part of 'login_cubit.dart';

class SigninError extends SigninState {
  final String message;

  SigninError(this.message);
}

final class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

@immutable
sealed class SigninState {}

class ResetPasswordSent extends SigninState {}

class UserNotVerified extends SigninState {}

class UserSignInSuccess extends SigninState {}
