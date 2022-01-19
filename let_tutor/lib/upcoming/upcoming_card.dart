import 'package:flutter/material.dart';
import 'package:let_tutor/model/booking_info.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class UpcomingCard extends StatelessWidget {
  UpcomingCard(this.booking);

  final BookingInfo booking;

  @override
  Widget build(BuildContext context) {
   
    Setting setting = context.watch<Setting>();


    DateTime start = DateTime.fromMicrosecondsSinceEpoch(booking.scheduleDetailInfo!.startPeriodTimestamp! * 1000, isUtc: false);
    DateTime end = DateTime.fromMicrosecondsSinceEpoch(booking.scheduleDetailInfo!.endPeriodTimestamp! * 1000, isUtc: false);

    int hourDifference = start.difference(DateTime.now()).inHours;

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
                    image: NetworkImage(booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.avatar!),
                  )
                ),
              ),
                          
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name!, style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),),
                    Row(
                      children: [ 
                        Text(start.year.toString() + '-' + (start.month < 10 ? ('0' + start.month.toString()) : start.month.toString()) + '-' + (start.day < 10 ? ('0' + start.day.toString()) : start.day.toString()),
                            style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),
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
                  onTap: hourDifference >= 2 ? () {
                    
                  } : null,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      color: hourDifference >= 2 ? Colors.white : Colors.grey,
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text (
                      setting.language == "English" ? 'Cancel' : "Hủy",
                      style: TextStyle(fontWeight: FontWeight.bold, color: hourDifference >= 2 ? Colors.black : Colors.white),
                    ),
                  ),
                )
              ),

              Expanded(
                child:  GestureDetector(
                  onTap:  () { },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text (
                      setting.language == "English" ? 'Go to Meeting' : "Vào lớp",
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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