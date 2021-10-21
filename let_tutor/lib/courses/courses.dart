import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/courses/course_card.dart';

class Courses extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: CupertinoSearchTextField(
                onChanged: (String value) {},
                onSubmitted: (String value) {},
                placeholder: 'Search course',
              )
            ),
  
            Expanded(
              child: ListView(
                children: [
                  CourseCard(AssetImage('images/course_picture.png'), 'Basic Conversation Topics', 'Gain confidence speaking about familiar topics', 'Beginner', 10),
                  CourseCard(AssetImage('images/course_picture2.png'), 'Life in the Internet Age', "Let's discuss how technology is changing the way we live", 'Intermediate', 9),
                ],
              )
            ),
          ]
        ),
      )
    );
  }
}