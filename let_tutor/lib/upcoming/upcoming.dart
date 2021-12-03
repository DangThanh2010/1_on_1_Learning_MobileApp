import 'package:flutter/material.dart';
import 'package:let_tutor/model/booking_dto.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/upcoming/upcoming_card.dart';
import 'package:provider/provider.dart';

class Upcoming extends StatelessWidget {

  List<BookingDTO> getListUpcoming(ListBookingDTO bookings){
    List<BookingDTO> result = [];
    for(int i = 0; i < bookings.list.length; i++){
      if(DateTime.now().compareTo(bookings.list[i].end) < 0 && bookings.list[i].isCancel == false){
        result.add(bookings.list[i]);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    ListBookingDTO bookings = context.watch<ListBookingDTO>();
    Setting setting = context.watch<Setting>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(setting.language == "English" ? 'Upcoming' : "Sắp diễn ra", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: getListUpcoming(bookings).map((e) => UpcomingCard(e)).toList()
        ),
      )
    );
  }
}