/*import 'package:flutter/material.dart';
import 'package:let_tutor/model/feedback_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/tutor_dto.dart';
import 'package:provider/provider.dart';

class FeedbackListCard extends StatelessWidget {
  FeedbackListCard(this.feedback);

  final FeedbackDTO feedback;

  @override
  Widget build(BuildContext context) {
    ListTutorDTO tutors = context.watch<ListTutorDTO>();
    TutorDTO? tutor = tutors.getTutor(feedback.idSender);
    Setting setting = context.watch<Setting>();

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
                    image: AssetImage(tutor!.avatar),
                  )
                ),
              ),
                          
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tutor.name, style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),),
                    Row(
                      children: [
                        Text((feedback.dateTime.hour < 10 ? ('0' + feedback.dateTime.hour.toString()) : feedback.dateTime.hour.toString()) + ':' + (feedback.dateTime.minute < 10 ? ('0' + feedback.dateTime.minute.toString()) : feedback.dateTime.minute.toString()) + ':' + (feedback.dateTime.second < 10 ? ('0' + feedback.dateTime.second.toString()) : feedback.dateTime.second.toString()) + ', ' + (feedback.dateTime.day < 10 ? ('0' + feedback.dateTime.day.toString()) : feedback.dateTime.day.toString()) + '/' + (feedback.dateTime.month < 10 ? ('0' + feedback.dateTime.month.toString()) : feedback.dateTime.month.toString()) + '/' + feedback.dateTime.year.toString(),
                              style: const TextStyle(color: Colors.red),),
                        Expanded(
                          child: 
                          Container (
                            margin: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${feedback.star}', style: const TextStyle(color: Colors.red),),
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
              feedback.comment,
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
}*/