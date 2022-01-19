// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleInfo _$ScheduleInfoFromJson(Map<String, dynamic> json) => ScheduleInfo(
      date: json['date'] as String?,
      startTimestamp: json['startTimestamp'] as int?,
      endTimestamp: json['endTimestamp'] as int?,
      id: json['id'] as String?,
      tutorId: json['tutorId'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      tutorInfo: json['tutorInfo'] == null
          ? null
          : TutorInfo.fromJson(json['tutorInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleInfoToJson(ScheduleInfo instance) =>
    <String, dynamic>{
      'date': instance.date,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
      'id': instance.id,
      'tutorId': instance.tutorId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'tutorInfo': instance.tutorInfo,
    };
