import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/topic_dto.dart';
import 'package:provider/provider.dart';

class Topic extends StatelessWidget {
  Topic(this.number, this.topic);

  final int number;
  final TopicDTO topic;

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
          color: setting.theme == "White" ? Colors.white : Colors.grey[800],
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.purple[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('${number}', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),),
            ),

            Text(topic.name, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white, fontWeight: FontWeight.bold),)
          ],
        ),
      )
    );
  }
}