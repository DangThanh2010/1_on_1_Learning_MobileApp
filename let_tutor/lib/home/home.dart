import 'package:flutter/material.dart';
import 'package:let_tutor/home/tutor_card.dart';
import 'package:let_tutor/home/white_button.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home(this.setSelectedIndex);

  final void Function(int) setSelectedIndex;

  @override
  Widget build(BuildContext context) {
    ListTutorDTO tutors = context.watch<ListTutorDTO>();

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
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
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
                        WhiteButton('Enter lesson room', (){ Navigator.pushNamed(context, "/video_conference");})
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: WhiteButton('Book more', (){ setSelectedIndex(3); })
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
                        onPressed: (){ setSelectedIndex(3); },
                        child: const Text('See all >')
                      )
                    )
                  ),
                ]
              )
            ),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tutors.list.map((e) => TutorCard(e.id)).toList()
            )
          ],
        ),
      )
    );
  }
}