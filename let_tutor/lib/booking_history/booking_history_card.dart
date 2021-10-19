import 'package:flutter/material.dart';

class BookingHistoryCard extends StatelessWidget {
  BookingHistoryCard(this.avatar, this.name, this.start, this.end);

  final ImageProvider avatar;
  final String name;
  final DateTime start;
  final DateTime end;

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.only(top:10, left: 20, right: 20, bottom: 10),
      elevation: 4,
      child: Row(
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
    );
  }
}