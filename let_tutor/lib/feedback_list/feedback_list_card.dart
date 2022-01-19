import 'package:flutter/material.dart';
import 'package:let_tutor/model/feedback_detail.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class FeedbackListCard extends StatelessWidget {
  FeedbackListCard(this.feedback);

  final FeedbackDetail feedback;

  @override
  Widget build(BuildContext context) {

    Setting setting = context.watch<Setting>();

    DateTime dateTime = DateTime.parse(feedback.createdAt!);

    return Card(
      color: setting.theme == "White" ? Colors.white : Colors.grey[800],
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
                    image: NetworkImage(feedback.firstInfo!.avatar!)
                  )
                ),
              ),
                          
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(feedback.firstInfo!.name!, style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),),
                    Row(
                      children: [
                        Text((dateTime.hour < 10 ? ('0' + dateTime.hour.toString()) : dateTime.hour.toString()) + ':' + (dateTime.minute < 10 ? ('0' + dateTime.minute.toString()) : dateTime.minute.toString()) + ':' + (dateTime.second < 10 ? ('0' + dateTime.second.toString()) : dateTime.second.toString()) + ', ' + (dateTime.day < 10 ? ('0' + dateTime.day.toString()) : dateTime.day.toString()) + '/' + (dateTime.month < 10 ? ('0' + dateTime.month.toString()) : dateTime.month.toString()) + '/' + dateTime.year.toString(),
                              style: const TextStyle(color: Colors.red),),
                        Expanded(
                          child: 
                          Container (
                            margin: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${feedback.rating}', style: const TextStyle(color: Colors.red),),
                                const Icon(Icons.star_rate, color: Colors.yellow,),    
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
              feedback.content!,
              maxLines: null,
              style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
            ),

            decoration: BoxDecoration(
              color: setting.theme == "White" ? Colors.white : Colors.grey[800],
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