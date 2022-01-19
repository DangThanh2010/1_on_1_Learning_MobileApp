// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListSchedule _$ListScheduleFromJson(Map<String, dynamic> json) => ListSchedule(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListScheduleToJson(ListSchedule instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
