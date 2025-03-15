import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/app_regex.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/snack_bar.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../logic/cubit/sign_up_cubit.dart';
import 'widgets/already_have_acc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscureText = true;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listenWhen: (previous, current) => previous != current,
        listener: _handleSignUpStates,
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 95.h, left: 16.w, right: 16.w),
              child: Form(key: _formKey, child: _buildSignUpForm()),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    super.dispose();
  }

  Widget _buildEmailField() {
    return AppTextFormField(
      controller: _emailController,
      hint: 'Email',
      textInputType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      textInputAction: TextInputAction.next,
      validator: _validateEmail,
    );
  }

  Widget _buildFirstNameField() {
    return AppTextFormField(
      controller: _firstNameController,
      hint: 'First Name',
      textInputType: TextInputType.name,
      autofillHints: const [AutofillHints.givenName],
      textInputAction: TextInputAction.next,
      validator: _validateName,
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('Sign Up', style: TextStyles.font24BlueBold),
      ),
    );
  }

  Widget _buildLastNameField() {
    return AppTextFormField(
      controller: _lastNameController,
      hint: 'Last Name',
      textInputType: TextInputType.name,
      autofillHints: const [AutofillHints.familyName],
      textInputAction: TextInputAction.next,
      validator: _validateName,
    );
  }

  Widget _buildPasswordField() {
    return AppTextFormField(
      controller: _passwordController,
      hint: 'Password',
      textInputType: TextInputType.visiblePassword,
      autofillHints: const [AutofillHints.newPassword],
      textInputAction: TextInputAction.done,
      isObscureText: _isObscureText,
      suffixIcon: GestureDetector(
        onTap: _togglePasswordVisibility,
        child: Icon(
          _isObscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
      ),
      validator: _validatePassword,
    );
  }

  Widget _buildSignUpButton() {
    return AppTextButton(
      buttonText: 'Sign Up',
      textStyle: TextStyles.font16WhiteSemiBold,
      onPressed: _handleSignUp,
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        _buildHeader(),
        verticalSpace(36),
        _buildFirstNameField(),
        verticalSpace(16),
        _buildLastNameField(),
        verticalSpace(16),
        _buildEmailField(),
        verticalSpace(16),
        _buildPasswordField(),
        verticalSpace(25),
        _buildSignUpButton(),
        verticalSpace(24),
        AlreadyHaveAcc(),
      ],
    );
  }

  void _clearFormFields() {
    _emailController.clear();
    _passwordController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
  }

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      final String fullName =
          '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}'
              .toTitleCase;
      await context.read<SignUpCubit>().signUpWithEmail(
        fullName,
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  void _handleSignUpStates(BuildContext context, SignUpState state) {
    if (state is SignUpLoading) {
      _showLoadingDialog();
    } else if (state is SignUpError) {
      context.pop();
      CustomSnackBar.showSnackBar(context, state.message);
    } else if (state is UserSingUpButNotVerified) {
      context.pop();
      _clearFormFields();
      CustomSnackBar.showSnackBar(
        context,
        'Don\'t forget to verify your email check inbox.',
      );
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  String? _validateEmail(String? value) {
    String email = (value ?? '').trim();
    _emailController.text = email;

    if (email.isEmpty) {
      return 'Please enter an email address';
    }

    if (!AppRegex.isEmailValid(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validateName(String? value) {
    String name = (value ?? '').trim();

    if (name.isEmpty) {
      return 'Please enter a Name';
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
