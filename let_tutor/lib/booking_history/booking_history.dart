import 'package:flutter/material.dart';
import 'package:let_tutor/booking_history/booking_history_card.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class BookingHistory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ListBookingDTO bookings = context.watch<ListBookingDTO>();
    Setting setting = context.watch<Setting>();
    
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: setting.theme == "White" ? Colors.black : Colors.white
        ),
        title: Text(setting.language == "English" ? 'Booking History' : "Lịch sử đặt lịch", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: bookings.list.map((e) => BookingHistoryCard(e)).toList()
        ),
      )
    );
  }
}