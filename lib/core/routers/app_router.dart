import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/ResetPassword/ui/reset_password_screen.dart';
import '../../features/attendance/ui/attendance_records_screen.dart';
import '../../features/auth/ui/local_auth_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/signin/logic/cubit/login_cubit.dart';
import '../../features/signin/ui/sign_in.dart';
import '../../features/signup/logic/cubit/sign_up_cubit.dart';
import '../../features/signup/ui/sign_up.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case Routes.authScreen:
        return MaterialPageRoute(builder: (_) => LocalAuthScreen());

      case Routes.attendanceRecordsScreen:
        return MaterialPageRoute(builder: (_) => AttendanceRecordsScreen());

      case Routes.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case Routes.signinScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<SigninCubit>(),
                child: const SignInScreen(),
              ),
        );

      case Routes.signupScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<SignUpCubit>(),
                child: const SignUpScreen(),
              ),
        );

      default:
        return null;
    }
  }
}
