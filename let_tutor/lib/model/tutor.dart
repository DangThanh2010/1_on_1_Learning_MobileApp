import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/feedback.dart';

part 'tutor.g.dart';

@JsonSerializable()
class Tutor {
  String? avatar;
  String? name;
  String? country;
  List<Feedback>? feedbacks;
  String? userId;
  String? bio;
  String? languages;

  double avgRating(){
    if(feedbacks == null || feedbacks!.length == 0){
      return 0;
    }
    double result = 0;
    for(var i = 0; i < feedbacks!.length; i++){
      result += double.parse(feedbacks![i].rating.toString());
    }
    return result/feedbacks!.length;
  }
 
  Tutor({this.avatar, this.name, this.country, this.feedbacks, this.userId, this.bio,});

  factory Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);

  Map<String, dynamic> toJson() => _$TutorToJson(this);
}