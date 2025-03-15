import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/services/attendance_service.dart';
import '../../../core/theme/font_weight_helper.dart';
import '../../../core/theme/text_styles.dart';
import 'widgets/card.dart';

class AttendanceRecordsScreen extends StatefulWidget {
  const AttendanceRecordsScreen({super.key});

  @override
  State<AttendanceRecordsScreen> createState() =>
      _AttendanceRecordsScreenState();
}

class _AttendanceRecordsScreenState extends State<AttendanceRecordsScreen> {
  final AttendanceService _attendance = AttendanceService();
  List<String> _records = [];
  List<String> _filteredRecords = [];
  DateTimeRange? _selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Attendance Records',
          style: TextStyle(fontWeight: FontWeightHelper.bold),
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showDateRangePicker,
            tooltip: 'Filter by Date',
          ),
          if (_selectedDateRange != null)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => _filterRecordsByDateRange(null),
              tooltip: 'Clear Filter',
            ),
        ],
      ),
      body: Container(
        child:
            _filteredRecords.isEmpty
                ? Center(
                  child: Text(
                    _selectedDateRange == null
                        ? 'No attendance records yet.'
                        : 'No records for selected date range.',
                    style: TextStyles.font14GrayRegular,
                  ),
                )
                : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  itemCount: _filteredRecords.length,
                  itemBuilder: (context, index) {
                    final record = _filteredRecords[index];
                    final dateTime = record.split(' - ')[0];
                    final location = record.split(' - ')[1];

                    return CustomCard(
                      record: record,
                      dateTime: dateTime,
                      location: location,
                    );
                  },
                ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  void _filterRecordsByDateRange(DateTimeRange? range) {
    if (range == null) {
      setState(() {
        _filteredRecords = _records;
        _selectedDateRange = null;
      });
      return;
    }

    setState(() {
      _selectedDateRange = range;
      _filteredRecords =
          _records.where((record) {
            final dateStr = record.split(' - ')[0];
            final recordDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateStr);
            return recordDate.isAfter(
                  range.start.subtract(Duration(days: 1)),
                ) &&
                recordDate.isBefore(range.end.add(Duration(days: 1)));
          }).toList();
    });
  }

  Future<void> _loadRecords() async {
    List<String> records = await _attendance.getAttendanceRecords();
    setState(() {
      _records = records;
      _filteredRecords = records;
    });
  }

  Future<void> _showDateRangePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      _filterRecordsByDateRange(picked);
    }
  }
}
