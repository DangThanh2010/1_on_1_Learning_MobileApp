import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/feedback_user_info.dart';

part 'feedback_detail.g.dart';

@JsonSerializable()
class FeedbackDetail {
  int? rating;
  String? content;
  String? createdAt;
  FeedbackUserInfo? firstInfo;

  FeedbackDetail(
      {
      this.rating,
      this.content,
      this.createdAt,
      this.firstInfo});
  
  factory FeedbackDetail.fromJson(Map<String, dynamic> json) => _$FeedbackDetailFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackDetailToJson(this);
}
