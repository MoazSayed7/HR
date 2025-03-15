import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/dependency_injection.dart';
import 'core/helpers/bloc_observer.dart';
import 'core/routers/app_router.dart';
import 'core/routers/routes.dart';
import 'firebase_options.dart';
import 'hr_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await Future.wait([
    setupGetIt(),
    ScreenUtil.ensureScreenSize(),
  ]);
  _initializeRoute();
  runApp(HRApp(appRouter: AppRouter()));
}

late String? initialRoute;

Future<void> _initializeRoute() async {
  User? user =
      FirebaseAuth.instance.currentUser; // Get the current user synchronously
  if (user == null || !user.emailVerified) {
    initialRoute = Routes.signinScreen;
  } else {
    initialRoute = Routes.authScreen;
  }
}
