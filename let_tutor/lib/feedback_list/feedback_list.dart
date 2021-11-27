import 'package:flutter/material.dart';
import 'package:let_tutor/feedback_list/feedback_list_card.dart';

class FeedbackList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback List', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [

            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('5.0', style: TextStyle(fontSize: 30, color: Colors.red),),
                  Icon(Icons.star_rate, color: Colors.yellow, size: 30,)
                ],
              )
            ),
            
            FeedbackListCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 21, 8, 0, 0, 0, 0),
              'Thank you for booking my class. I hope to see you again soon. Keep learning the language.',
            ),

            FeedbackListCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 19, 8, 30, 2, 0, 0),
              'Thank you for booking my class. I hope to see you again soon. Keep learning the language.',
            ),

            FeedbackListCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 18, 11, 24, 30, 0, 0),
              'Thank you for booking my class. I hope to see you again soon. Keep learning the language.',
            ),

            FeedbackListCard(
              AssetImage('images/avatar.jpg'),
              'April Corpuz',
              DateTime(2021, 10, 18, 8, 40, 8, 0, 0),
              'Thank you for booking my class. I hope to see you again soon. Keep learning the language.',
            ),


          ],
        ),
      )
    );
  }
}