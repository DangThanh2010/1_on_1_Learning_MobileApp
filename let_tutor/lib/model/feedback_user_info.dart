import 'package:json_annotation/json_annotation.dart';

part 'feedback_user_info.g.dart';

@JsonSerializable()
class FeedbackUserInfo {
  String? avatar;
  String? name;

  FeedbackUserInfo(
      {
      this.avatar,
      this.name,
      });
  
  factory FeedbackUserInfo.fromJson(Map<String, dynamic> json) => _$FeedbackUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackUserInfoToJson(this);
}