import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/helpers/snack_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class CustomCard extends StatelessWidget {
  final String record;
  final String dateTime;
  final String location;
  const CustomCard({
    super.key,
    required this.record,
    required this.dateTime,
    required this.location,
  });
  @override
  Widget build(BuildContext context) {
    void openGoogleMaps(String record) async {
      final locationPart = record.split(' - ')[1];
      final lat = locationPart.split(', ')[0].replaceAll('Lat: ', '');
      final lng = locationPart.split(', ')[1].replaceAll('Lon: ', '');
      final url = 'https://maps.google.com/?q=$lat,$lng';

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        if (!context.mounted) return;
        CustomSnackBar.showSnackBar(context, 'Could not open Google Maps');
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 8.0.h),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        color: ColorsManager.lightBlue,
        child: InkWell(
          onTap: () => openGoogleMaps(record),
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0.w,
              vertical: 8.0.h,
            ),
            leading: CircleAvatar(
              backgroundColor: ColorsManager.mainBlue.withAlpha(50),
              child: Icon(Icons.access_time, color: ColorsManager.mainBlue),
            ),
            title: Text(dateTime, style: TextStyles.font18DarkBlueBold),
            subtitle: Text(location, style: TextStyles.font13GrayRegular),
            trailing: Icon(Icons.map_rounded, color: ColorsManager.mainBlue),
          ),
        ),
      ),
    );
  }
}
