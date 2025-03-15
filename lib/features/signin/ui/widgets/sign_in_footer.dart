import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routers/routes.dart';
import '../../../../core/theme/text_styles.dart';

class SignInFooter extends StatelessWidget {
  const SignInFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8.w,
      children: [
        Text(
          'Don\'t have an account?',
          style: TextStyles.font13DarkBlueRegular,
        ),
        InkWell(
          onTap: () {
            context.pushReplacementNamed(Routes.signupScreen);
          },
          child: Text('Sign Up', style: TextStyles.font13BlueSemiBold),
        ),
      ],
    );
  }
}
