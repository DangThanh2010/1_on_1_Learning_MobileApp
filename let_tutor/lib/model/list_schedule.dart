import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/schedule.dart';

part 'list_schedule.g.dart';

@JsonSerializable()

class ListSchedule {
  String? message;
  List<Schedule>? data;

  ListSchedule({this.message, this.data});
  factory ListSchedule.fromJson(Map<String, dynamic> json) => _$ListScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ListScheduleToJson(this);
}