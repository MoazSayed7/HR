import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  SigninCubit() : super(SigninInitial());

  Future<void> resetPassword(String email) async {
    emit(SigninLoading());
    try {
      await _auth.sendPasswordResetEmail(email: email);
      emit(ResetPasswordSent());
    } catch (e) {
      emit(SigninError(e.toString()));
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(SigninLoading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user!.emailVerified) {
        emit(UserSignInSuccess());
      } else {
        await _auth.signOut();
        emit(SigninError('Email not verified. Please check your email.'));
        emit(UserNotVerified());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SigninError('No User found for that Email.'));
      } else if (e.code == 'wrong-password') {
        emit(SigninError('Wrong Password provided for that User.'));
      } else {
        emit(SigninError(e.code));
      }
    } catch (e) {
      emit(SigninError(e.toString()));
    }
  }
}
