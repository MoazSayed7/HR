import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUpWithEmail(
    String name,
    String email,
    String password,
  ) async {
    emit(SignUpLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _auth.currentUser!.updateDisplayName(name);
      await _auth.currentUser!.sendEmailVerification();
      await _auth.signOut();
      emit(UserSingUpButNotVerified());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(
          SignUpError(
            'This account already exists for that Email. Please go and Login.',
          ),
        );
      } else {
        emit(SignUpError(e.message!));
      }
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}
