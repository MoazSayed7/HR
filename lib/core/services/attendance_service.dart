import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../helpers/shared_pref_helper.dart';

class AttendanceService {
  final String _userId = FirebaseAuth.instance.currentUser!.uid;
  Future<List<String>> getAttendanceRecords() async {
    return await SharedPrefHelper.getStringList('attendance_$_userId');
  }

  Future<String?> logAttendance() async {
    if (await _checkLocationPermission()) {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      );
      String timestamp = DateFormat(
        'yyyy-MM-dd HH:mm:ss',
      ).format(DateTime.now());
      List<String> records = await getAttendanceRecords();
      records.add(
        '$timestamp - Lat: ${position.latitude}, Lon: ${position.longitude}',
      );
      await SharedPrefHelper.setData('attendance_$_userId', records);
      return timestamp;
    }
    return null;
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }
    return true;
  }
}
