import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/tutor_more_info.dart';

part 'tutor_detail_info.g.dart';

@JsonSerializable()
class TutorDetailInfo {
  String? userId;
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  TutorMoreInfo? user;
  TutorMoreInfo? User;
  bool? isFavorite;
  double? avgRating;

  TutorDetailInfo(
      {
      this.userId,
      this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.user,
      this.User,
      this.isFavorite,
      this.avgRating,});
  
  factory TutorDetailInfo.fromJson(Map<String, dynamic> json) => _$TutorDetailInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TutorDetailInfoToJson(this);
}