import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/feedback_detail.dart';
import 'package:let_tutor/model/learn_topic.dart';
import 'package:let_tutor/model/wallet_info.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  bool? isActivated;
  WalletInfo? walletInfo;
  List<FeedbackDetail>? feedbacks;
  //List<Null>? courses;
  //Null? requireNote;
  String? level;
  List<LearnTopic>? learnTopics;
  List<LearnTopic>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  int? avgRating;

  User(
      {this.id,
      this.email,
      this.name,
      this.avatar,
      this.country,
      this.phone,
      this.roles,
      this.language,
      this.birthday,
      this.isActivated,
      this.walletInfo,
      this.feedbacks,
      //this.courses,
      //this.requireNote,
      this.level,
      this.learnTopics,
      this.testPreparations,
      this.isPhoneActivated,
      this.timezone,
      this.avgRating});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}