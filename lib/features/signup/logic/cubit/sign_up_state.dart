part of 'sign_up_cubit.dart';

class SignUpError extends SignUpState {
  final String message;

  SignUpError(this.message);
}

final class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

@immutable
sealed class SignUpState {}

class UserSingUpButNotVerified extends SignUpState {}
