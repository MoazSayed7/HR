import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/app_regex.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/snack_bar.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/routers/routes.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../logic/cubit/login_cubit.dart';
import 'widgets/sign_in_footer.dart';
import 'widgets/sign_in_header.dart';

class SignInContent extends StatefulWidget {
  const SignInContent({super.key});

  @override
  State<SignInContent> createState() => _SignInContentState();
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      buildWhen: (previous, current) => previous != current,
      listenWhen: (previous, current) => previous != current,
      listener: _handleStateChanges,
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 101.0.h, left: 16.w, right: 16.w),
                child: const SignInContent(),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleStateChanges(BuildContext context, SigninState state) async {
    if (state is SigninLoading) {
      _showLoadingDialog(context);
    } else if (state is SigninError) {
      context.pop();
      CustomSnackBar.showSnackBar(context, state.message);
    } else if (state is UserSignInSuccess) {
      context.pop();
      if (!context.mounted) return;
      context.pushNamedAndRemoveUntil(
        Routes.homeScreen,
        predicate: (route) => false,
      );
    } else if (state is UserNotVerified) {
      CustomSnackBar.showSnackBar(
        context,
        'Please check your mail and verify your email.',
      );
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _SignInContentState extends State<SignInContent> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: context.read<SigninCubit>().formKey,
        child: Column(
          children: [
            const SignInHeader(),
            verticalSpace(36),
            _buildEmailField(),
            verticalSpace(16),
            _buildPasswordField(),
            verticalSpace(32),
            _buildSignInButton(),
            verticalSpace(12),
            _buildForgotPasswordButton(),
            verticalSpace(35),
            const SignInFooter(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _attemptSignIn() async {
    if (context.read<SigninCubit>().formKey.currentState!.validate()) {
      await context.read<SigninCubit>().signInWithEmail(
        emailController.text,
        passwordController.text,
      );
    }
  }

  Widget _buildEmailField() {
    return AppTextFormField(
      autofillHints: const [AutofillHints.email],
      textInputAction: TextInputAction.next,
      hint: 'Email',
      textInputType: TextInputType.emailAddress,
      controller: emailController,
      validator: _validateEmail,
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {
        context.pushNamed(Routes.resetPasswordScreen);
      },
      child: Text('Forgot Password?', style: TextStyles.font13DarkBlueRegular),
    );
  }

  Widget _buildPasswordField() {
    return AppTextFormField(
      autofillHints: const [AutofillHints.password],
      hint: 'Password',
      textInputAction: TextInputAction.done,
      onEditingComplete: _attemptSignIn,
      textInputType: TextInputType.visiblePassword,
      validator: _validatePassword,
      controller: passwordController,
      isObscureText: isObscureText,
      suffixIcon: GestureDetector(
        onTap: _togglePasswordVisibility,
        child: Icon(
          isObscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return AppTextButton(
      textStyle: TextStyles.font16WhiteSemiBold,
      key: const ValueKey('sign_in_button'),
      buttonText: 'Sign In',
      onPressed: _attemptSignIn,
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      isObscureText = !isObscureText;
    });
  }

  String? _validateEmail(String? value) {
    String email = (value ?? '').trim();
    emailController.text = email;

    if (email.isEmpty) {
      return 'Please enter an email address';
    }

    if (!AppRegex.isEmailValid(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty || !AppRegex.isPasswordValid(value)) {
      return 'Please enter a valid password';
    }
    return null;
  }
}
