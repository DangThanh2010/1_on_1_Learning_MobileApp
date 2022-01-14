import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/feedback_detail.dart';

part 'tutor_more_info.g.dart';

@JsonSerializable()
class TutorMoreInfo{
  String? avatar;
  String? name;
  String? country;
  List<FeedbackDetail>? feedbacks;

  TutorMoreInfo(
      {
      this.avatar,
      this.name,
      this.country,
      this.feedbacks,
    });
  
  factory TutorMoreInfo.fromJson(Map<String, dynamic> json) => _$TutorMoreInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TutorMoreInfoToJson(this);
}