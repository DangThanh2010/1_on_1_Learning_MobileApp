import 'package:flutter/material.dart';
import 'package:let_tutor/model/comment_dto.dart';

class ListCommentDTO extends ChangeNotifier{
  ListCommentDTO(this.list);

  final List<CommentDTO> list;

  void addComment(CommentDTO item){
    list.add(item);
    list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    notifyListeners();
  }

  int getLengthForTutor(int idtutor){
    int result = 0;
    for(int i = 0; i < list.length; i++){
      if(list[i].idTutor == idtutor){
        result++;
      }
    }
    return result;
  }

  int getRateForTutor(int idtutor){
    double result = 0;
    double length = 0;
    for(int i = 0; i < list.length; i++){
      if(list[i].idTutor == idtutor){
        result += list[i].star;
        length++;
      }
    }
    return length == 0 ? 0 : (result / length).round();
  }

  int getNextId(){
    int result = 0;
    for(var i = 0; i < list.length; i++){
      if(list[i].id > result){
        result = list[i].id;
      }
    }
    return ++result;
  }
}