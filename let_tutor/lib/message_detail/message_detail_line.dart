import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class MessageDetailLine extends StatelessWidget {
  MessageDetailLine(this.name, this.isSentByMe, this.content);

  final String name;
  final bool isSentByMe;
  final String content;

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    
    return Container(
      padding: const EdgeInsets.all(10),
      margin: isSentByMe ? const EdgeInsets.only(top: 5, left: 50, right: 20, bottom: 5) : const EdgeInsets.only(top: 5, left: 20, right: 50, bottom: 5),
      
      decoration: BoxDecoration(
        color: isSentByMe ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isSentByMe ? setting.language == "English" ? 'Me' : 'Tôi' : name, style: TextStyle(color: isSentByMe ? Colors.blue[100] : Colors.grey[300],),),
          Text(content, style: const TextStyle(color: Colors.white,), maxLines: null,)
        ],
      )
    );
  }
}