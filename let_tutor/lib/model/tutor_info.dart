import 'package:json_annotation/json_annotation.dart';

part 'tutor_info.g.dart';

@JsonSerializable()
class TutorInfo {
  String? id;
  String? level;
  String? email;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;
  int? timezone;
  bool? isPhoneAuthActivated;
  String? createdAt;
  String? updatedAt;

  TutorInfo(
      {this.id,
      this.level,
      this.email,
      this.avatar,
      this.name,
      this.country,
      this.phone,
      this.birthday,
      this.requestPassword,
      this.isActivated,
      this.timezone,
      this.isPhoneAuthActivated,
      this.createdAt,
      this.updatedAt,});
  
  factory TutorInfo.fromJson(Map<String, dynamic> json) => _$TutorInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TutorInfoToJson(this);
}