import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/home/tutor_card.dart';
import 'package:let_tutor/home/white_button.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.black),),
        actions: [
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/avatar.jpg'),
                )
              ),
            ),
            onTap: () {},
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              color: Colors.blue,
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: 
                      const Text(
                        'Total lesson time is 12 hours 55 minutes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: 
                      const Text(
                        'Upcoming lesson',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: const Text(
                            'Sat, 16 Oct 21 00:00 - 00:25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            )
                          )
                        ), 
                        WhiteButton('Enter lesson room')
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: WhiteButton('Book more')
                    )
                  ]
                )
            ),

            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                children: [
                  const Text(
                    'Recommended Tutors',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                  ),

                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('See all >')
                      )
                    )
                  ),
                ]
              )
            ),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TutorCard(AssetImage('images/avatar.jpg'), 'April Corpuz', [Tag('English', true), Tag('Vietnamese', true)], 
                          'I was born in Chester, United Kingdom, but now live in Vietnam. I am a person of varied interests, I love baking, reading, photography and languages. I enjoy teaching English to all ages and levels as I believe it opens the door to global opportunities. I am a fun, talkative person who loves to find out about others cultures and experience.'),
                TutorCard(AssetImage('images/avatar2.jpg'), 'Keegan', [Tag('English', true), Tag('Tagalog', true)], 
                          'I was born in Chester, United Kingdom, but now live in Manila, Philippines. I am a person of varied interests, I love baking, reading, photography and languages. I enjoy teaching English to all ages and levels as I believe it opens the door to global opportunities. I am a fun, talkative person who loves to find out about others cultures and experience.'),
                TutorCard(AssetImage('images/avatar3.jpg'), 'Levi', [Tag('English', true), Tag('Japanese', true), Tag('Vietnamese', true), Tag('Korean', true)], 
                          'I was born in Chester, United Kingdom, but now live in Japan. I am a person of varied interests, I love baking, reading, photography and languages. I enjoy teaching English to all ages and levels as I believe it opens the door to global opportunities. I am a fun, talkative person who loves to find out about others cultures and experience.'),
              ],
            )
          ],
        ),
      )
    );
  }
}