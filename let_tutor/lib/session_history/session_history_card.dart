import 'package:flutter/material.dart';
import 'package:let_tutor/model/booking_info.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/session_history/give_feedback_dialog.dart';
import 'package:let_tutor/tutor_detail/tutor_detail.dart';
import 'package:provider/provider.dart';

class SessionHistoryCard extends StatelessWidget {
  SessionHistoryCard(this.booking);

  final BookingInfo booking;

  String getTimeToLearn(DateTime start, DateTime end){
    int seconds = end.difference(start).inSeconds;
    int second = seconds % 60;
    int minute = (seconds ~/ 60) % 60;
    int hour = (seconds ~/ 60) ~/ 60;

    String result = (hour < 10 ? ('0' + hour.toString()) : hour.toString()) + ':' + (minute < 10 ? ('0' + minute.toString()) : minute.toString()) + ':' + (second < 10 ? ('0' + second.toString()) : second.toString());

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    DateTime start = DateTime.fromMicrosecondsSinceEpoch(booking.scheduleDetailInfo!.startPeriodTimestamp! * 1000, isUtc: false);
    DateTime end = DateTime.fromMicrosecondsSinceEpoch(booking.scheduleDetailInfo!.endPeriodTimestamp! * 1000, isUtc: false);

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
                        Icon(Icons.calendar_today_outlined, color: setting.theme == "White" ? Colors.black : Colors.white),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text((start.hour < 10 ? ('0' + start.hour.toString()) : start.hour.toString()) + ':' + (start.minute < 10 ? ('0' + start.minute.toString()) : start.minute.toString()) + ':' + (start.second < 10 ? ('0' + start.second.toString()) : start.second.toString()) + ', ' + (start.day < 10 ? ('0' + start.day.toString()) : start.day.toString()) + '/' + (start.month < 10 ? ('0' + start.month.toString()) : start.month.toString()) + '/' + start.year.toString(),
                                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                          )
                        )
                      ]
                    ),

                    Row(
                      children: [
                        Icon(Icons.schedule_outlined, color: setting.theme == "White" ? Colors.black : Colors.white),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(getTimeToLearn(start, end), style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)),
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
                  onTap: () {
                    
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return GiveFeedbackDialog(booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name!, booking.scheduleDetailInfo!.scheduleInfo!.tutorId!, booking.id!);              
                      }
                    );
                    
                  },
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
                      setting.language == "English" ? 'Give feedback' : "Gửi đánh giá",
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )
              ),

              Expanded(
                child:  GestureDetector(
                  onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SafeArea(child: TutorDetail(booking.scheduleDetailInfo!.scheduleInfo!.tutorId!))),
                  );},
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
                      setting.language == "English" ? 'See Tutor Details' : "Xem chi tiết gia sư",
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
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