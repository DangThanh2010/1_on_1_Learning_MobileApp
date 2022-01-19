import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/model/booking_info.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:let_tutor/video_conference/video_conference.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class UpcomingCard extends StatelessWidget {
  UpcomingCard(this.booking, this.callBack);

  final BookingInfo booking;
  final void Function(String) callBack;

  Future<int> cancelClass(scheduleId) async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.delete(Uri.parse(APILINK + "booking"),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
      },
      body: jsonEncode({
        "scheduleDetailIds":  [scheduleId],
      }));
    return (res.statusCode);
  }

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
                  onTap: hourDifference >= 2 ? () async {
                    int code = await cancelClass(booking.scheduleDetailId);

                    if(code == 200){
                      callBack(setting.language == "English" ? "Cancel successfully": "Hủy buổi học thành công");
                    } else {
                      callBack(setting.language == "English" ? "Cancel unsuccessfully": "Hủy buổi học thất bại");
                    }

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
                  onTap:  () {
                    String link = booking.studentMeetingLink!;
                    String token = link.split('=')[1];
                    String b64 = token.split('.')[1];

                    List<int> res = base64.decode(base64.normalize(b64));

                    Map<String,dynamic> info = jsonDecode(utf8.decode(res));
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SafeArea(child: VideoConference(info['room'], token, info['context']['user']['name'] ?? "", info['context']['user']['email'], start ))),
                  ); },
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