import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/favorite_tutor.dart';
import 'package:let_tutor/model/tutors.dart';

part 'list_tutor.g.dart';

@JsonSerializable()
class ListTutor {
  Tutors? tutors;
  List<FavoriteTutor>? favoriteTutor;

  ListTutor({this.tutors, this.favoriteTutor});

  bool checkFavoriteTutor(String? id){
    if(favoriteTutor == null){
      return false;
    }
    for(var i = 0; i < favoriteTutor!.length; i++)
    {
      if(favoriteTutor![i].secondId == id){
        return true;
      }
    }
    return false;
  }

  factory ListTutor.fromJson(Map<String, dynamic> json) => _$ListTutorFromJson(json);

  Map<String, dynamic> toJson() => _$ListTutorToJson(this);
}