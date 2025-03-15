import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routers/routes.dart';
import '../../../../core/theme/text_styles.dart';

class AlreadyHaveAcc extends StatelessWidget {
  const AlreadyHaveAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8.w,
      children: [
        Text(
          'Already have an account?',
          style: TextStyles.font13DarkBlueRegular,
        ),
        InkWell(
          onTap: () => context.pushReplacementNamed(Routes.signinScreen),
          child: Text('Sign In', style: TextStyles.font13BlueSemiBold),
        ),
      ],
    );
  }
}
