import 'dart:async';

import 'package:flutter/material.dart';

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
    if(this.hour <= 0 && this.minute <= 0 && this.second <= 0)
      return new Time(0,0,0);
    else
      return new Time(this.hour, this.minute, this.second - 1);
  }
}

class VideoCoference extends StatefulWidget {

  @override
  _VideoCoferenceState createState() => _VideoCoferenceState();

}

class _VideoCoferenceState extends State<VideoCoference>{

  Time timeWait = new Time(0,0,0);

  @override
  void initState() {
    super.initState();
    timeWait = new Time(DateTime.now().hour, DateTime.now().minute, DateTime.now().second);
  }

  @override
  Widget build(BuildContext context) {
    Timer timer = new Timer(const Duration(milliseconds: 1000), () {
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
              'Lesson will be started after\n\n'
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
