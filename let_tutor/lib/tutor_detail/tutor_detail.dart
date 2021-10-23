import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/tutor_detail/booking_dialog.dart';
import 'package:let_tutor/tutor_detail/comment.dart';
import 'package:let_tutor/tutor_detail/icon_text.dart';
import 'package:let_tutor/tutor_detail/intro.dart';
import 'package:let_tutor/tutor_detail/report_dialog.dart';

class TutorDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Widget TitleName(String title){
      return Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),)
      );
    } 

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Center(
                child: Text(
                  'Video',
                  textAlign: TextAlign.center,
                  )
              )
            ),

            Intro(AssetImage('images/avatar3.jpg'), 'Levi', 'Japan', false),

            Button('Booking', () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BookingDialog([DateTime(2021, 10, 24, 22, 0, 0, 0, 0), DateTime(2021, 10, 24, 23, 0, 0, 0, 0), DateTime(2021, 10, 25, 7, 0, 0, 0, 0),  DateTime(2021, 10, 25, 23, 0, 0, 0, 0), DateTime(2021, 10, 26, 8, 0, 0, 0, 0),],
                      [DateTime(2021, 10, 24, 22, 25, 0, 0, 0), DateTime(2021, 10, 24, 23, 25, 0, 0, 0), DateTime(2021, 10, 25, 7, 25, 0, 0, 0), DateTime(2021, 10, 25, 23, 25, 0, 0, 0),  DateTime(2021, 10, 26, 8, 25, 0, 0, 0)]);
                }
              );
            }),

            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   IconText(Icons.chat, 'Message', () {},),
                   IconText(Icons.report, 'Report', () {
                     showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReportDialog('Levi'); 
                      }
                    );
                  },)
                ],
              ) 
            ),

            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                'I was born in Chester, United Kingdom, but now live in Japan. I am a person of varied interests, I love baking, reading, photography and languages. I enjoy teaching English to all ages and levels as I believe it opens the door to global opportunities. I am a fun, talkative person who loves to find out about others cultures and experience.'
              ) 
            ),

            TitleName('Languages'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child:  SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tag('English', true),
                    Tag('Japanese', true),
                    Tag('Vietnamese', true),
                    Tag('Korean', true),
                  ],
                ),
              )
            ),
           
            TitleName('Education'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text('IELTS 8.0 (Speaking: 8.0, Listening: 8.5, Reading: 8.5, Writing: 7.5')
            ),

            TitleName('Experience'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text('3 years')
            ),

            TitleName('Interests'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text('Teaching English, listening to music, shopping, eating')
            ),

            TitleName('Profession'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text('English teacher')
            ),

            TitleName('Specialties'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child:  SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tag('English for Kids', true),
                    Tag('Conversational English', true),
                    Tag('IELTS', true),
                  ],
                ),
              )
            ),

            TitleName('Rating and Comment (3)'),
            Comment(AssetImage('images/avatar.jpg'), 'April Corpuz', 'Happy', '10:12:10, 17/10/2021'),
            Comment(AssetImage('images/avatar2.jpg'), 'Keegan', 'Very good', '10:10:10, 16/10/2021'),
            Comment(AssetImage('images/avatar2.jpg'), 'Keegan', 'Very nice', '11:10:10, 16/10/2021'),
          ],
        ),
      )
    );
  }
}