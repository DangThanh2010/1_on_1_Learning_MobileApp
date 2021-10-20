import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/message/message_list_tile.dart';

class Message extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats', style: TextStyle(color: Colors.black),),
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
                placeholder: 'Search message',
              )
            ),
  
            Expanded(
              child: ListView(
                children: [
                  MessageListTile(
                    AssetImage('images/avatar.jpg'),
                    'April Corpuz',
                    'Nice to meet you, too',
                    DateTime(2021, 10, 18, 11, 5, 0, 0, 0),
                    true,
                    false,
                  ),
                  
                  MessageListTile(
                    AssetImage('images/avatar2.jpg'),
                    'Keegan',
                    'I have your class on Thursday.',
                    DateTime(2021, 10, 17, 13, 8, 0, 0, 0),
                    false,
                    true,
                  ),

                  MessageListTile(
                    AssetImage('images/avatar3.jpg'),
                    'Levi',
                    'See you later.',
                    DateTime(2021, 10, 17, 8, 15, 0, 0, 0),
                    true,
                    true,
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