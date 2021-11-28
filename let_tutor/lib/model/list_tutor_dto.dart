import 'package:flutter/material.dart';
import 'package:let_tutor/model/tutor_dto.dart';

class ListTutorDTO extends ChangeNotifier{
  ListTutorDTO(this.list);

  final List<TutorDTO> list;

  void setFavourite(int id){
    for(var i = 0; i < list.length; i++){
      if(id == list[i].id){
        list.insert(0, TutorDTO(id, list[i].avatar, list[i].name, list[i].nation, true, list[i].introduction, list[i].education, list[i].experience, list[i].interests, list[i].profession));
        list.remove(list[i + 1]);
        break;
      }
    }
    notifyListeners();
  }

  void setNotFavourite(int id){
    for(var i = 0; i < list.length; i++){
      if(id == list[i].id){
        list.add(TutorDTO(id, list[i].avatar, list[i].name, list[i].nation, false, list[i].introduction, list[i].education, list[i].experience, list[i].interests, list[i].profession));
        list.remove(list[i]);
        break;
      }
    }
    notifyListeners();
  }

  TutorDTO? getTutor(int id){
    for(int i = 0; i < list.length; i++){
      if(list[i].id == id){
        return list[i];
      }
    }
    return null;
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