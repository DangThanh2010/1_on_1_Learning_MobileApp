import 'package:flutter/material.dart';
import 'package:let_tutor/model/booking_dto.dart';

class ListBookingDTO extends ChangeNotifier{
  ListBookingDTO(this.list);

  final List<BookingDTO> list;

  void addBooking(BookingDTO item){
    list.add(item);
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