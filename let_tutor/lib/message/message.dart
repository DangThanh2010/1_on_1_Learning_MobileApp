import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/message/message_list_tile.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class Message extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return Scaffold(
      appBar: AppBar(
        title: Text(setting.language == "English" ? 'Chats' : "Tin nhắn", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: CupertinoSearchTextField(
                onChanged: (String value) {},
                onSubmitted: (String value) {},
                backgroundColor: setting.theme == "White" ? Colors.grey[200] : Colors.grey,
                itemColor: setting.theme == "White" ? Colors.black : Colors.white,
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                placeholder: setting.language == "English" ? 'Search message' : "Tìm kiếm tin nhắn",
                placeholderStyle: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
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