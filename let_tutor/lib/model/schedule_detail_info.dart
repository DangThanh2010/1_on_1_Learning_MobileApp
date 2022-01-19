import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/schedule_info.dart';


part 'schedule_detail_info.g.dart';

@JsonSerializable()
class ScheduleDetailInfo {
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  String? createdAt;
  String? updatedAt;
  ScheduleInfo? scheduleInfo;

  ScheduleDetailInfo(
      {this.startPeriodTimestamp,
      this.endPeriodTimestamp,
      this.id,
      this.scheduleId,
      this.startPeriod,
      this.endPeriod,
      this.createdAt,
      this.updatedAt,
      this.scheduleInfo});
  
  factory ScheduleDetailInfo.fromJson(Map<String, dynamic> json) => _$ScheduleDetailInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDetailInfoToJson(this);
}