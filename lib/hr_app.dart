import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routers/app_router.dart';
import 'core/theme/colors.dart';
import 'main.dart';

class HRApp extends StatelessWidget {
  final AppRouter appRouter;

  const HRApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 813),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HR App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: ColorsManager.mainBlue,
            ),
          ),
          initialRoute: initialRoute,
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
