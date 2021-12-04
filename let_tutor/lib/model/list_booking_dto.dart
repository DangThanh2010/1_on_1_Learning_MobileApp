import 'package:flutter/material.dart';
import 'package:let_tutor/model/booking_dto.dart';

class ListBookingDTO extends ChangeNotifier{
  ListBookingDTO(this.list);

  final List<BookingDTO> list;

  void addBooking(BookingDTO item){
    list.add(item);
    list.sort((a, b) => a.start.compareTo(b.start));
    notifyListeners();
  }

  void setCancel(int id){
    for(var i = 0; i < list.length; i++){
      if(id == list[i].id){
        list.insert(i, BookingDTO(list[i].id, list[i].idTutor, list[i].start, list[i].end, true, list[i].isFeedbacked));
        list.remove(list[i + 1]);
        break;
      }
    }
    notifyListeners();
  }

  void setFeedback(int id){
    for(var i = 0; i < list.length; i++){
      if(id == list[i].id){
        list.insert(i, BookingDTO(list[i].id, list[i].idTutor, list[i].start, list[i].end, list[i].isCancel, true));
        list.remove(list[i + 1]);
        break;
      }
    }
    notifyListeners();
  }

  BookingDTO? getBooking(int id){
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