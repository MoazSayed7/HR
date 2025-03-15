import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';

class AppTextFormField extends StatelessWidget {
  final String hint;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final Iterable<String>? autofillHints;
  final void Function()? onEditingComplete;
  final Function(String)? onChanged;
  final bool? isObscureText;
  final TextInputAction? textInputAction;
  final bool? isDense;
  final TextEditingController? controller;
  final Function(String?) validator;
  const AppTextFormField({
    super.key,
    required this.hint,
    this.suffixIcon,
    this.isObscureText,
    this.isDense,
    this.controller,
    this.onChanged,
    this.focusNode,
    required this.validator,
    this.textInputType,
    this.autofillHints,
    this.textInputAction,
    this.onEditingComplete,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
      validator: (value) {
        return validator(value);
      },
      keyboardType: textInputType,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintFadeDuration: const Duration(milliseconds: 500),
        hintStyle: TextStyles.font14LightGrayRegular,
        isDense: isDense ?? true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.lighterGray,
            width: 1.3.w,
          ),
          gapPadding: 10.w,
          borderRadius: BorderRadius.circular(16.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsManager.mainBlue, width: 1.3.w),
          gapPadding: 10.w,
          borderRadius: BorderRadius.circular(16.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.3.w),
          gapPadding: 10.w,
          borderRadius: BorderRadius.circular(16.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.3.w),
          gapPadding: 10.w,
          borderRadius: BorderRadius.circular(16.r),
        ),
        suffixIcon: suffixIcon,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyles.font14DarkBlueMedium,
    );
  }
}
