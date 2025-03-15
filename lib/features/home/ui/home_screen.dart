import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/snack_bar.dart';
import '../../../core/routers/routes.dart';
import '../../../core/services/attendance_service.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/font_weight_helper.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/app_text_button.dart';

class HomeScreen extends StatelessWidget {
  final AttendanceService _attendance = AttendanceService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HR App',
          style: TextStyle(fontWeight: FontWeightHelper.bold),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: ColorsManager.mainBlue),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              context.pushNamedAndRemoveUntil(
                Routes.signinScreen,
                predicate: (route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.h,
          children: [
            AppTextButton(
              onPressed: () => _logAttendance(context),
              buttonWidth: 300.w,
              buttonText: 'Log Attendance',
              textStyle: TextStyles.font16WhiteSemiBold,
            ),
            AppTextButton(
              onPressed:
                  () => context.pushNamed(Routes.attendanceRecordsScreen),
              buttonText: 'View Attendance Records',
              buttonWidth: 300.w,
              textStyle: TextStyles.font16WhiteSemiBold,
            ),
          ],
        ),
      ),
    );
  }

  void _logAttendance(BuildContext context) async {
    String? timestamp = await _attendance.logAttendance();
    if (!context.mounted) return;
    CustomSnackBar.showSnackBar(
      context,
      timestamp != null
          ? 'Attendance logged at $timestamp'
          : 'Failed to log attendance',
    );
  }
}
