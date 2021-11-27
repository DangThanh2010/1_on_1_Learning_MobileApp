import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/session_history/session_history_card.dart';

class SessionHistory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black
        ),
        title: const Text('Session History', style: TextStyle(color: Colors.black),),
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
                placeholder: 'Search session history',
              )
            ),
  
            Expanded(
              child: ListView(
                children: [
                  SessionHistoryCard(
                    AssetImage('images/avatar.jpg'),
                    'April Corpuz',
                    DateTime(2021, 10, 18, 22, 0, 0, 0, 0),
                    false,
                    '00:25:11'
                  ),

                  SessionHistoryCard(
                    AssetImage('images/avatar.jpg'),
                    'April Corpuz',
                    DateTime(2021, 10, 18, 11, 5, 0, 0, 0),
                    false,
                    '00:30:01'
                  ),

                  SessionHistoryCard(
                    AssetImage('images/avatar.jpg'),
                    'April Corpuz',
                    DateTime(2021, 10, 17, 22, 0, 0, 0, 0),
                    false,
                    '00:25:11'
                  ),

                  SessionHistoryCard(
                    AssetImage('images/avatar.jpg'),
                    'April Corpuz',
                    DateTime(2021, 10, 17, 9, 0, 0, 0, 0),
                    false,
                    '00:29:56'
                  ),

                  SessionHistoryCard(
                    AssetImage('images/avatar.jpg'),
                    'April Corpuz',
                    DateTime(2021, 10, 16, 13, 40, 0, 0, 0),
                    false,
                    '00:20:09'
                  ),
                ],
              )
            ),
          ]
        ),
      )
    );
  }
}