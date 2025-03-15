import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/snack_bar.dart';
import '../../../core/routers/routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/app_text_button.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.h,
          children: [
            Icon(Icons.fingerprint, size: 80.sp, color: ColorsManager.mainBlue),
            Text(
              'Please authenticate to proceed',
              style: TextStyles.font18DarkBlueBold,
            ),
            AppTextButton(
              onPressed: _authenticate,
              buttonText: 'Try Again',
              textStyle: TextStyles.font16WhiteSemiBold,
              buttonWidth: 160.w,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    try {
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        _navigateToHome();
        return;
      }

      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Scan your fingerprint to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        _navigateToHome();
      } else {
        if (!mounted) return;
        CustomSnackBar.showSnackBar(context, 'Authentication failed');
      }
    } catch (e) {
      debugPrint('Error during authentication: $e');
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    context.pushReplacementNamed(Routes.homeScreen);
  }
}
