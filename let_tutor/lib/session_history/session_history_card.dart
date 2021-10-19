import 'package:flutter/material.dart';

class SessionHistoryCard extends StatelessWidget {
  SessionHistoryCard(this.avatar, this.name, this.start, this.isFeedbacked, this.timeToLearn);

  final ImageProvider avatar;
  final String name;
  final DateTime start;
  final bool isFeedbacked;
  final String timeToLearn;

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
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold),),

                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text((start.hour < 10 ? ('0' + start.hour.toString()) : start.hour.toString()) + ':' + (start.minute < 10 ? ('0' + start.minute.toString()) : start.minute.toString()) + ':' + (start.second < 10 ? ('0' + start.second.toString()) : start.second.toString()) + ', ' + (start.day < 10 ? ('0' + start.day.toString()) : start.day.toString()) + '/' + (start.month < 10 ? ('0' + start.month.toString()) : start.month.toString()) + '/' + start.year.toString()),
                        )
                      ]
                    ),

                    Row(
                      children: [
                        Icon(Icons.schedule_outlined),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(timeToLearn),
                        )
                      ]
                    ),

                    Row(
                      children: [
                        Icon(Icons.star_outline),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(isFeedbacked ? 'You feedbacked this session' : 'Not feedback yet'),
                        )
                      ]
                    ),
                  ],
                )
              )
            ]
          ),
              
          Row(
            children: [
              Expanded(
                child:  GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text (
                      'Give Feedback',
                      style: TextStyle(fontWeight: FontWeight.bold, color:  Colors.white),
                    ),
                  ),
                )
              ),

              Expanded(
                child:  GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text (
                      'See Tutor Details',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                )
              ),
            ],
          )
        ]
      )
    );
  }
}