import 'package:flutter/material.dart';

class FeedbackListCard extends StatelessWidget {
  FeedbackListCard(this.avatar, this.name, this.feedbackDateTime, this.comment);

  final ImageProvider avatar;
  final String name;
  final DateTime feedbackDateTime;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top:10, left: 20, right: 20, bottom: 10),
      elevation: 4,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
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
                          
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                    Row(
                      children: [
                        Text((feedbackDateTime.hour < 10 ? ('0' + feedbackDateTime.hour.toString()) : feedbackDateTime.hour.toString()) + ':' + (feedbackDateTime.minute < 10 ? ('0' + feedbackDateTime.minute.toString()) : feedbackDateTime.minute.toString()) + ':' + (feedbackDateTime.second < 10 ? ('0' + feedbackDateTime.second.toString()) : feedbackDateTime.second.toString()) + ', ' + (feedbackDateTime.day < 10 ? ('0' + feedbackDateTime.day.toString()) : feedbackDateTime.day.toString()) + '/' + (feedbackDateTime.month < 10 ? ('0' + feedbackDateTime.month.toString()) : feedbackDateTime.month.toString()) + '/' + feedbackDateTime.year.toString(),
                              style: TextStyle(color: Colors.red),),
                        Expanded(
                          child: 
                          Container (
                            margin: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('5.0', style: TextStyle(color: Colors.red),),
                                Icon(Icons.star_rate, color: Colors.yellow,),    
                              ],
                            )
                          )
                        ),
                      ],
                    ),
                  ]
                )
              )
            ],
          ),

          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            alignment: Alignment.topLeft,
            child: Text(
              comment,
              maxLines: null,
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.5, color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 1,
                  spreadRadius: 2,
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}