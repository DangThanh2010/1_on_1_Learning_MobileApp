// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_detail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDetailInfo _$ScheduleDetailInfoFromJson(Map<String, dynamic> json) =>
    ScheduleDetailInfo(
      startPeriodTimestamp: json['startPeriodTimestamp'] as int?,
      endPeriodTimestamp: json['endPeriodTimestamp'] as int?,
      id: json['id'] as String?,
      scheduleId: json['scheduleId'] as String?,
      startPeriod: json['startPeriod'] as String?,
      endPeriod: json['endPeriod'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      scheduleInfo: json['scheduleInfo'] == null
          ? null
          : ScheduleInfo.fromJson(json['scheduleInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleDetailInfoToJson(ScheduleDetailInfo instance) =>
    <String, dynamic>{
      'startPeriodTimestamp': instance.startPeriodTimestamp,
      'endPeriodTimestamp': instance.endPeriodTimestamp,
      'id': instance.id,
      'scheduleId': instance.scheduleId,
      'startPeriod': instance.startPeriod,
      'endPeriod': instance.endPeriod,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'scheduleInfo': instance.scheduleInfo,
    };
