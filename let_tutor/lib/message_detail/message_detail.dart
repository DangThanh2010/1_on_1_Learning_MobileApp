import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/message_detail/message_detail_line.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class MessageDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: setting.theme == "White" ? Colors.black : Colors.white
        ),
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('April Corpuz', style: TextStyle(fontSize: 15, color: setting.theme == "White" ? Colors.black : Colors.white),),
                Text(setting.language == "English" ? 'Teacher' : "Gia sư", style: TextStyle(fontSize: 15, color: setting.theme == "White" ? Colors.grey : Colors.white),),
              ],
            ),
          ]
        ),
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
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
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
                  suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.send, color: Colors.blue,)),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  hintText: setting.language == "English" ? 'Type your message...' : 'Nhập tin nhắn...', 
                  hintStyle: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white), 
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