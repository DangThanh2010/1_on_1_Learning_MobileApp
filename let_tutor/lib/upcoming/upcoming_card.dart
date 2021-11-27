import 'package:flutter/material.dart';

class UpcomingCard extends StatelessWidget {
  UpcomingCard(this.avatar, this.name, this.start, this.end);

  final ImageProvider avatar;
  final String name;
  final DateTime start;
  final DateTime end;

  @override
  Widget build(BuildContext context) {
    int hourDifference = start.difference(DateTime.now()).inHours;

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
                        Text(start.year.toString() + '-' + (start.month < 10 ? ('0' + start.month.toString()) : start.month.toString()) + '-' + (start.day < 10 ? ('0' + start.day.toString()) : start.day.toString())),
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          child: Text((start.hour < 10 ? ('0' + start.hour.toString()) : start.hour.toString()) + ':' + (start.minute < 10 ? ('0' + start.minute.toString()) : start.minute.toString()), style: const TextStyle(color: Colors.blue),),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                          
                        const Text('-'),
                              
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(left: 5,right: 5),
                          child: Text((end.hour < 10 ? ('0' + end.hour.toString()) : end.hour.toString()) + ':' + (end.minute < 10 ? ('0' + end.minute.toString()) : end.minute.toString()), style: const TextStyle(color: Colors.red),),
                          
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ],
                    )
                  ]
                )
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child:  GestureDetector(
                  onTap: hourDifference >= 2 ? () {} : null,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      color: hourDifference >= 2 ? Colors.white : Colors.grey,
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text (
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold, color: hourDifference >= 2 ? Colors.black : Colors.white),
                    ),
                  ),
                )
              ),

              Expanded(
                child:  GestureDetector(
                  onTap: hourDifference <= 24 ? () { Navigator.pushNamed(context, "/video_conference");} : null,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      color: hourDifference <= 24 ? Colors.blue : Colors.grey,
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text (
                      'Go to Meeting',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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