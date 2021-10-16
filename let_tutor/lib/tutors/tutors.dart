import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/tutors/tutor_card_for_search.dart';


class Tutors extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutors', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: CupertinoSearchTextField(
                onChanged: (String value) {},
                onSubmitted: (String value) {},
                placeholder: 'Search Tutors',
              )
            ),
            
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: TextButton(
                onPressed: () {}, 
                child: const Text('Become a tutor >')
              )
            ),
            
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Tag('All', true),
                  Tag('English for Kids', false),
                  Tag('Business English', false),
                  Tag('Conversational English', false),
                ],),
              )
            ),


            Expanded(
              child: ListView(
                children: [
                  TutorCardForSearch(AssetImage('images/avatar.jpg'), 'April Corpuz', [Tag('English', true), Tag('Vietnamese', true)], 
                          'I was born in Chester, United Kingdom, but now live in Vietnam. I am a person of varied interests, I love baking, reading, photography and languages. I enjoy teaching English to all ages and levels as I believe it opens the door to global opportunities. I am a fun, talkative person who loves to find out about others cultures and experience.'),
                  TutorCardForSearch(AssetImage('images/avatar2.jpg'), 'Keegan', [Tag('English', true), Tag('Tagalog', true)], 
                          'I was born in Chester, United Kingdom, but now live in Manila, Philippines. I am a person of varied interests, I love baking, reading, photography and languages. I enjoy teaching English to all ages and levels as I believe it opens the door to global opportunities. I am a fun, talkative person who loves to find out about others cultures and experience.'),
                  TutorCardForSearch(AssetImage('images/avatar3.jpg'), 'Levi', [Tag('English', true), Tag('Japanese', true), Tag('Vietnamese', true), Tag('Korean', true)], 
                          'I was born in Chester, United Kingdom, but now live in Japan. I am a person of varied interests, I love baking, reading, photography and languages. I enjoy teaching English to all ages and levels as I believe it opens the door to global opportunities. I am a fun, talkative person who loves to find out about others cultures and experience.'),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}