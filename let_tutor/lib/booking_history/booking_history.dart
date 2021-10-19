import 'package:flutter/material.dart';
import 'package:let_tutor/booking_history/booking_history_card.dart';

class BookingHistory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            BookingHistoryCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 21, 8, 0, 0, 0, 0),
              DateTime(2021, 10, 21, 8, 25, 0, 0, 0)
            ),

            BookingHistoryCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 20, 23, 0, 0, 0, 0),
              DateTime(2021, 10, 20, 23, 25, 0, 0, 0)
            ),

            BookingHistoryCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 20, 7, 0, 0, 0, 0),
              DateTime(2021, 10, 20, 7, 25, 0, 0, 0)
            ),

            BookingHistoryCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 19, 23, 0, 0, 0, 0),
              DateTime(2021, 10, 19, 23, 25, 0, 0, 0)
            ),

            BookingHistoryCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 19, 22, 0, 0, 0, 0),
              DateTime(2021, 10, 19, 22, 25, 0, 0, 0)
            ),

            BookingHistoryCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 18, 22, 0, 0, 0, 0),
              DateTime(2021, 10, 18, 22, 25, 0, 0, 0)
            ),

            BookingHistoryCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 18, 11, 5, 0, 0, 0),
              DateTime(2021, 10, 18, 11, 35, 0, 0, 0)
            ),

            BookingHistoryCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 17, 22, 0, 0, 0, 0),
              DateTime(2021, 10, 17, 22, 25, 0, 0, 0)
            ),

            BookingHistoryCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 17, 9, 0, 0, 0, 0),
              DateTime(2021, 10, 17, 9, 30, 0, 0, 0)
            ),

            BookingHistoryCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 16, 13, 40, 0, 0, 0),
              DateTime(2021, 10, 16, 14, 10, 0, 0, 0)
            ),

          ],
        ),
      )
    );
  }
}