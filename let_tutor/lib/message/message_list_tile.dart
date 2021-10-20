import 'package:flutter/material.dart';
import 'package:let_tutor/message/message.dart';

class MessageListTile extends StatelessWidget {
  MessageListTile(this.avatar, this.name, this.message, this.timeSend, this.isActive, this.isSentByMe);

  final ImageProvider avatar;
  final String name;
  final String message;
  final DateTime timeSend;
  final bool isActive;
  final bool isSentByMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListTile(
        leading: Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: avatar,
                )
              ),
            ),

            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: isActive ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2)
                ),
              )
            ),
          ]
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold,)),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                isSentByMe ? 'You: ' + message : message,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Text(
              (timeSend.day < 10 ? ('0' + timeSend.day.toString()) : timeSend.day.toString()) + '-' + (timeSend.month < 10 ? ('0' + timeSend.month.toString()) : timeSend.month.toString()) + '-' + timeSend.year.toString()
              + ', ' + (timeSend.hour < 10 ? ('0' + timeSend.hour.toString()) : timeSend.hour.toString()) + ':' + (timeSend.minute < 10 ? ('0' + timeSend.minute.toString()) : timeSend.minute.toString()),  
            ),
          ]
        ),
        onTap: () {},
      )
    );
  }
}