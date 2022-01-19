import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/model/list_schedule.dart';
import 'package:let_tutor/model/schedule.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingDialog extends StatelessWidget{
  BookingDialog(this.idTutor, this.callBack);

  final String idTutor;
  final void Function(String) callBack;

  Future<ListSchedule> getSchedules(id) async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.post(Uri.parse(APILINK + "schedule"),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                },
                body: jsonEncode({
                  "tutorId": id
                }));
    if(res.statusCode == 200){
      var listSchedule = ListSchedule.fromJson(jsonDecode(res.body));  
      return listSchedule;
    }else {
      return ListSchedule();
    }
  }

  List<Widget> generateListButton(List<Schedule>? schedules, BuildContext context, Setting setting){
    List<Widget> result = [];
    schedules!.sort((a,b) => a.startTimestamp! - b.startTimestamp!);
    for (var element in schedules) {
      if(element.isBooked == false ){
        DateTime start = DateTime.fromMicrosecondsSinceEpoch(element.startTimestamp! * 1000, isUtc: false);
        DateTime end = DateTime.fromMicrosecondsSinceEpoch(element.endTimestamp! * 1000, isUtc: false);
        if(start.difference(DateTime.now()).inSeconds >= 0){
          result.add(
            Button(start.year.toString() + '-' + (start.month < 10 ? ('0' + start.month.toString()) : start.month.toString()) + '-' + (start.day < 10 ? ('0' + start.day.toString()) : start.day.toString())
            + '\n' + (start.hour < 10 ? ('0' + start.hour.toString()) : start.hour.toString()) + ':' + (start.minute < 10 ? ('0' + start.minute.toString()) : start.minute.toString())
            + '-' + (end.hour < 10 ? ('0' + end.hour.toString()) : end.hour.toString()) + ':' + (end.minute < 10 ? ('0' + end.minute.toString()) : end.minute.toString()),
            ()  {
            })
          );
        }
      }
    }
    return result;
  }

  Widget setupContent(String idTutor, context, Setting setting) {
    return(
      FutureBuilder<ListSchedule>(
        future: getSchedules(idTutor),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Center(
                child: CircularProgressIndicator()
              )
            );
          }
          if (snapshot.hasData) {
            if(snapshot.data.data == null){
              return Container(
                color: setting.theme == "White" ? Colors.white : Colors.grey[800],
                alignment: Alignment.center,
                child: Center(
                  child: Text(setting.language == "English" ? 'Error.' : 'Đã xảy ra lỗi.',
                      style: TextStyle(fontWeight: FontWeight.bold,
                                        color: setting.theme == "White" ? Colors.black : Colors.white, ),)
                )
              );
            }
            if(snapshot.data.data.length == 0){
              return Container(
                color: setting.theme == "White" ? Colors.white : Colors.grey[800],
                alignment: Alignment.center,
                child: Center(
                  child: Text(setting.language == "English" ? 'No data.' : 'Không có dữ liệu.',
                              style: TextStyle(fontWeight: FontWeight.bold,
                                              color: setting.theme == "White" ? Colors.black : Colors.white, ),)
                )
              );
            }
            return 
              Container(
                color: setting.theme == "White" ? Colors.white : Colors.grey[800],
                height: 300, 
                width: 300, 
                child: ListView(
                  children: generateListButton(snapshot.data.data, context, setting),)
            );
          }
          return Container();
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return AlertDialog(  
      backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800], 
      title: Center(
        child: Text(setting.language == "English" ? 'Pick your schedule' : 'Hãy chọn lịch học bạn muốn',
                    style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)),
      ),
      content: setupContent(idTutor, context, setting),
    );
  }
}