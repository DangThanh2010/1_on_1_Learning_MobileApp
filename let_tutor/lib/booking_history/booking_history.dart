import 'package:flutter/material.dart';
import 'package:let_tutor/booking_history/booking_history_card.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:provider/provider.dart';

class BookingHistory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ListBookingDTO bookings = context.watch<ListBookingDTO>();
    
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black
        ),
        title: const Text('Booking History', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: bookings.list.map((e) => BookingHistoryCard(e)).toList()
        ),
      )
    );
  }
}