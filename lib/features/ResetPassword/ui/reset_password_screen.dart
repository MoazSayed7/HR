import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/app_regex.dart';
import '../../../core/helpers/snack_bar.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/app_text_form_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 70.h),
            child: AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 32.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          ColorsManager.mainBlue,
                        ),
                        iconColor: WidgetStatePropertyAll(Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7.w),
                      child: Text(
                        'Reset Password',
                        style: TextStyles.font24BlueBold,
                      ),
                    ),
                    AppTextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.email],
                      validator: _validateEmail,
                      hint: 'Email',
                      textInputType: TextInputType.emailAddress,
                    ),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Center(
                          child: AppTextButton(
                            buttonText: 'Reset',
                            textStyle: TextStyles.font16WhiteSemiBold,
                            onPressed: _handleResetPassword,
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;

      CustomSnackBar.showSnackBar(
        context,
        'We sent a link to reset your password.',
      );

      _emailController.clear();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      final message =
          e.code == 'user-not-found' ? 'Email not found' : e.message!;

      CustomSnackBar.showSnackBar(context, message);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String? _validateEmail(String? value) {
    final email = (value ?? '').trim();

    if (email.isEmpty) {
      return 'Please enter an email address';
    }

    if (!AppRegex.isEmailValid(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }
}
