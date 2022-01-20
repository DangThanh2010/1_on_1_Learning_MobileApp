import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class VideoConference extends StatefulWidget {
  VideoConference(this.room, this.token, this.name, this.email, this.time);
  final String room;
  final String token;
  final String name;
  final String email;
  final DateTime time;


  @override
  _VideoConferenceState createState() => _VideoConferenceState(room, token, name, email, time);
}

class _VideoConferenceState extends State<VideoConference> {
  _VideoConferenceState(this.room, this.token,  this.name, this.email, this.time);
  final String room;
  final String token;
  final String name;
  final String email;
  final DateTime time;

  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));

    _joinMeeting();
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return TimeWait(time);
  }

  _joinMeeting() async {

    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    
    var options = JitsiMeetingOptions(room: room)
      ..serverURL = "https://meet.lettutor.com"
      ..subject = "Lettutor"
      ..userDisplayName = name
      ..userEmail = email
      ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..token = token
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": room,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": name}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
    Navigator.pop(context);
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}

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

  Time upTime(){
    return Time(hour, minute, second + 1);
  }
}

class TimeWait extends StatefulWidget {
  TimeWait(this.time);

  final DateTime time;

  @override
  _TimeWaitState createState() => _TimeWaitState(time);

}

class _TimeWaitState extends State<TimeWait>{

  _TimeWaitState(this.time);

  final DateTime time;

  Time timeWait = Time(0,0,0);
  bool wait = true;

  @override
  void initState() {
    super.initState();
    if(DateTime.now().difference(time).inSeconds < 0){
      int seconds = time.difference(DateTime.now()).inSeconds;
      int second = seconds % 60;
      int minute = (seconds ~/ 60) % 60;
      int hour = (seconds ~/ 60) ~/ 60;
      timeWait = Time(hour, minute, second);
      wait = true;
    } else {
      int seconds = DateTime.now().difference(time).inSeconds;
      int second = seconds % 60;
      int minute = (seconds ~/ 60) % 60;
      int hour = (seconds ~/ 60) ~/ 60;
      timeWait = Time(hour, minute, second);
      wait = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    Timer timer = Timer(const Duration(milliseconds: 1000), () {
      if(wait){
        if(timeWait.hour == 0 && timeWait.minute == 0 && timeWait.second == 0){
          setState(() {
            timeWait = timeWait.upTime();
            wait = false;
          });
        } else {
          setState(() {
            timeWait = timeWait.downTime();
          });
        }
      } else {
         setState(() {
          timeWait = timeWait.upTime();
        });
      }
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
              (setting.language == "English" ? (wait ? 'Lesson will be started after\n\n' : 'Lesson lasted\n\n' ) : (wait ? 'Lớp học sẽ bắt đầu sau\n\n' : 'Lớp học đã diễn ra\n\n'))
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