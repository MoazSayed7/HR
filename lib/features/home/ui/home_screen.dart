import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr/core/helpers/extensions.dart';

import '../../../core/routers/routes.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/app_text_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              auth.currentUser!.displayName!.toTitleCase,
              style: TextStyles.font12DarkBlueRegular,
            ),
            AppTextButton(
              buttonText: 'Sign out',
              textStyle: TextStyles.font16WhiteSemiBold,
              onPressed: () async {
                await auth.signOut();
                if (!context.mounted) return;
                context.pushNamedAndRemoveUntil(
                  Routes.signinScreen,
                  predicate: (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
