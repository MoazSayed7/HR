import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/dependency_injection.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'core/routers/app_router.dart';
import 'core/routers/routes.dart';
import 'firebase_options.dart';
import 'hr_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupGetIt();
  await ScreenUtil.ensureScreenSize();
  FirebaseAuth.instance.authStateChanges().listen((user) async {
    if (user == null || !user.emailVerified) {
      initialRoute = Routes.signinScreen;
    } else {
      bool localAuth = await SharedPrefHelper.getBool('auth_screen_enabled');
      if (localAuth) {
        initialRoute = Routes.authScreen;
      } else {
        initialRoute = Routes.homeScreen;
      }
    }
  });
  runApp(HRApp(appRouter: AppRouter()));
}

late String? initialRoute;
