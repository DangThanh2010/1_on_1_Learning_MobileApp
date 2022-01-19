import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/schedule_detail_info.dart';

part 'booking_info.g.dart';

@JsonSerializable()
class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;
  bool? isDeleted;
  ScheduleDetailInfo? scheduleDetailInfo;
  bool? showRecordUrl;

  BookingInfo(
      {this.createdAtTimeStamp,
      this.updatedAtTimeStamp,
      this.id,
      this.userId,
      this.scheduleDetailId,
      this.tutorMeetingLink,
      this.studentMeetingLink,
      this.studentRequest,
      this.tutorReview,
      this.scoreByTutor,
      this.createdAt,
      this.updatedAt,
      this.recordUrl,
      this.isDeleted,
      this.scheduleDetailInfo,
      this.showRecordUrl});
  
  factory BookingInfo.fromJson(Map<String, dynamic> json) => _$BookingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BookingInfoToJson(this);
}