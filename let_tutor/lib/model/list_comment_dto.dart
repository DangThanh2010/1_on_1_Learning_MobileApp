import 'package:flutter/material.dart';
import 'package:let_tutor/model/comment_dto.dart';

class ListCommentDTO extends ChangeNotifier{
  ListCommentDTO(this.list);

  final List<CommentDTO> list;

  void addComment(CommentDTO item){
    list.add(item);
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