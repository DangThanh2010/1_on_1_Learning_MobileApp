// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCourse _$ListCourseFromJson(Map<String, dynamic> json) => ListCourse(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListCourseToJson(ListCourse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };
