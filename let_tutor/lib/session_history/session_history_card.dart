import 'package:flutter/material.dart';
import 'package:let_tutor/model/booking_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/tutor_dto.dart';
import 'package:let_tutor/session_history/give_feedback_dialog.dart';
import 'package:let_tutor/tutor_detail/tutor_detail.dart';
import 'package:provider/provider.dart';

class SessionHistoryCard extends StatelessWidget {
  SessionHistoryCard(this.booking);

  final BookingDTO booking;

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
    ListTutorDTO tutors = context.watch<ListTutorDTO>();
    TutorDTO? tutor = tutors.getTutor(booking.idTutor);
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
                        Icon(Icons.calendar_today_outlined, color: setting.theme == "White" ? Colors.black : Colors.white),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text((booking.start.hour < 10 ? ('0' + booking.start.hour.toString()) : booking.start.hour.toString()) + ':' + (booking.start.minute < 10 ? ('0' + booking.start.minute.toString()) : booking.start.minute.toString()) + ':' + (booking.start.second < 10 ? ('0' + booking.start.second.toString()) : booking.start.second.toString()) + ', ' + (booking.start.day < 10 ? ('0' + booking.start.day.toString()) : booking.start.day.toString()) + '/' + (booking.start.month < 10 ? ('0' + booking.start.month.toString()) : booking.start.month.toString()) + '/' + booking.start.year.toString(),
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
                          child: Text(getTimeToLearn(booking.start, booking.end), style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)),
                        )
                      ]
                    ),

                    Row(
                      children: [
                        Icon(Icons.star_outline, color: setting.theme == "White" ? Colors.black : Colors.white),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(booking.isFeedbacked ? (setting.language == "English" ? 'You feedbacked this session' : "Bạn đã đánh giá") : (setting.language == "English" ? 'Not feedback yet' : "Bạn chưa đánh giá"),
                                 style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)),
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
                        return GiveFeedbackDialog(tutor.name);              
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
                    MaterialPageRoute(builder: (context) => SafeArea(child: TutorDetail(tutor.id))),
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