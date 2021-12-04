import 'dart:async';

import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class Time {
  int hour;
  int minute;
  int second;

  Time(this.hour, this.minute, this.second){
    if(second >= 60)
    {
      minute++;
      second = 0;
    }
    if(minute >= 60)
    {
      hour++;
      minute = 0;
    }

    if(second < 0)
    {
      minute--;
      second = 59;
    }

    if(minute < 0)
    {
      hour--;
      minute = 59;
    }
  }

  Time downTime(){
    if(hour <= 0 && minute <= 0 && second <= 0) {
      return Time(0,0,0);
    } else {
      return Time(hour, minute, second - 1);
    }
  }
}

class VideoCoference extends StatefulWidget {

  @override
  _VideoCoferenceState createState() => _VideoCoferenceState();

}

class _VideoCoferenceState extends State<VideoCoference>{

  Time timeWait = Time(0,0,0);

  @override
  void initState() {
    super.initState();
    timeWait = Time(DateTime.now().hour, DateTime.now().minute, DateTime.now().second);
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    Timer timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        timeWait = timeWait.downTime();
      });
    });

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
          ),

          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text(
              (setting.language == "English" ? 'Lesson will be started after\n\n' : 'Lớp học sẽ bắt đầu sau\n\n')
              + (timeWait.hour < 10 ? ('0' + timeWait.hour.toString()) : timeWait.hour.toString())
              + ' : ' + (timeWait.minute < 10 ? ('0' + timeWait.minute.toString()) : timeWait.minute.toString())
              + ' : ' + (timeWait.second < 10 ? ('0' + timeWait.second.toString()) : timeWait.second.toString()),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ),
        ]
      ),
    );
  }
}
