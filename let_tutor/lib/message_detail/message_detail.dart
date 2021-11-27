import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/message_detail/message_detail_line.dart';

class MessageDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/avatar.jpg'),
                )
              ),
            ),              
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('April Corpuz', style: TextStyle(fontSize: 15, color: Colors.black),),
                Text('Teacher', style: TextStyle(fontSize: 15, color: Colors.grey),),
              ],
            ),
          ]
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView(
                children: [
                  MessageDetailLine(
                    'April Corpuz',
                    true,
                    'Hello Teacher'
                  ),

                  MessageDetailLine(
                    'April Corpuz',
                    false,
                    'Hi'
                  ),

                  MessageDetailLine(
                    'April Corpuz',
                    true,
                    'Nice to meet you!'
                  ),

                  MessageDetailLine(
                    'April Corpuz',
                    false,
                    'Nice to meet you, too'
                  ),
                ],
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: TextField(
                onSubmitted: (value) {},
                onChanged: (value) {},
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.send, color: Colors.blue,)),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  hintText: 'Type your message...',  
                ),
                maxLines: null,
              )
            ),
          ]
        ),
      )
    );
  }
}