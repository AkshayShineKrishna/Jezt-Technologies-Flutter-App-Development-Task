import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DashBoardResponse {
  @JsonKey(name: "company_name")
  String? companyName;
  @JsonKey(name: "employee_count")
  int? employeeCount;
  @JsonKey(name: "camera_count")
  int? cameraCount;
  @JsonKey(name: "attendance_percentage")
  int? attendancePercentage;
  @JsonKey(name: "last_date_attendance_percentage")
  int? lastDateAttendancePercentage;
  @JsonKey(name: "last_5_attendance_percentages")
  List<dynamic>? last5AttendancePercentages;
  @JsonKey(name: "today_date")
  String? todayDate;
  @JsonKey(name: "Todays_Total_Imgs")
  int? todaysTotalImgs;
  @JsonKey(name: "Todays_Format_Total")
  String? todaysFormatTotal;
  @JsonKey(name: "Total_Images_Processed")
  String? totalImagesProcessed;
  @JsonKey(name: "pp")
  bool? pp;
  @JsonKey(name: "detail")
  String? detail;

  DashBoardResponse({
    this.companyName,
    this.employeeCount,
    this.cameraCount,
    this.attendancePercentage,
    this.lastDateAttendancePercentage,
    this.last5AttendancePercentages,
    this.todayDate,
    this.todaysTotalImgs,
    this.todaysFormatTotal,
    this.totalImagesProcessed,
    this.pp,
    this.detail
  });

  factory DashBoardResponse.fromJson(Map<String, dynamic> json) {
    return DashBoardResponse(
      companyName: json['company_name'] as String?,
      employeeCount: json['employee_count'] as int?,
      cameraCount: json['camera_count'] as int?,
      attendancePercentage: json['attendance_percentage'] as int?,
      lastDateAttendancePercentage:
          json['last_date_attendance_percentage'] as int?,
      last5AttendancePercentages:
          json['last_5_attendance_percentages'] as List<dynamic>?,
      todayDate: json['today_date'] as String?,
      todaysTotalImgs: json['Todays_Total_Imgs'] as int?,
      todaysFormatTotal: json['Todays_Format_Total'] as String?,
      totalImagesProcessed: json['Total_Images_Processed'] as String?,
      pp: json['pp'] as bool?,
      detail: json['detail'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'company_name': companyName,
    'employee_count': employeeCount,
    'camera_count': cameraCount,
    'attendance_percentage': attendancePercentage,
    'last_date_attendance_percentage': lastDateAttendancePercentage,
    'last_5_attendance_percentages': last5AttendancePercentages,
    'today_date': todayDate,
    'Todays_Total_Imgs': todaysTotalImgs,
    'Todays_Format_Total': todaysFormatTotal,
    'Total_Images_Processed': totalImagesProcessed,
    'pp': pp,
    'detail':detail
  };
}
