import 'package:flutter/material.dart';
import 'package:let_tutor/upcoming/upcoming_card.dart';

class Upcoming extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            UpcomingCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 19, 22, 0, 0, 0, 0),
              DateTime(2021, 10, 19, 22, 25, 0, 0, 0)
            ),

            UpcomingCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 19, 23, 0, 0, 0, 0),
              DateTime(2021, 10, 19, 23, 25, 0, 0, 0)
            ),

            UpcomingCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 20, 7, 0, 0, 0, 0),
              DateTime(2021, 10, 20, 7, 25, 0, 0, 0)
            ),

            UpcomingCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 20, 23, 0, 0, 0, 0),
              DateTime(2021, 10, 20, 23, 25, 0, 0, 0)
            ),

            UpcomingCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 21, 8, 0, 0, 0, 0),
              DateTime(2021, 10, 21, 8, 25, 0, 0, 0)
            ),




          ],
        ),
      )
    );
  }
}