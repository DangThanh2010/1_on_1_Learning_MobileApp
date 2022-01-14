import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/course.dart';

part 'list_course.g.dart';

@JsonSerializable()
class ListCourse {
  int? count;
  List<Course>? rows;

  ListCourse({this.count, this.rows});

  factory ListCourse.fromJson(Map<String, dynamic> json) => _$ListCourseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCourseToJson(this);
}