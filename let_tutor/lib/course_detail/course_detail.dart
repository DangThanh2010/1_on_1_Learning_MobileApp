import 'package:flutter/material.dart';
import 'package:let_tutor/course_detail/topic.dart';

class CourseDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Widget PartName(String name){
      return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
      );
    } 

    List<Widget> GenerateListTopic(List<String> topics){
      int temp = 1;

      List<Widget> result = [];
    
      topics.forEach(
        (topic) {
          result.add(Topic(temp, topic));
          temp++;
        }
      );
      return result;
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              height:180,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/course_picture.png'),
                )
              ),
            ),

            PartName('About Course'),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text(
                'Gain confidence speaking about familiar topics'
              ) 
            ),

            PartName('Overview'),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  Text('Why take this course?'), 
                ],
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text("It can be intimidating to speak with a foreigner, no matter how much grammar and vocabulary you've mastered. If you have basic knowledge of English but have not spent much time speaking, this course will help you ease into your first English conversations.")
            ),

            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  Text('What will you be able to do?'), 
                ],
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text('This course covers vocabulary at the CEFR A2 level. You will build confidence while learning to speak about a variety of common, everyday topics. In addition, you will build implicit grammar knowledge as your tutor models correct answers and corrects your mistakes.')
            ),

            PartName('Experience Level'),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text(
                'Beginner'
              ) 
            ),

            PartName('Course Length'),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text(
                '10 Topics'
              ) 
            ),

            PartName('List Topics'),

          ]
          + 
          GenerateListTopic(['Foods You Love', 'Your Job',
             'Playing and Watching Sports', 'The Best Pet', 'Having Fun in Your Free Time',
             'Your Daily Routine', 'Childhood Memories',
             'Your Family Members', 'Your Hometown', 'Shopping Habits'])
        ),
      )
    );
  }
}
