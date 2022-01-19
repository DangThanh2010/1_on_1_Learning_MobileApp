import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:jitsi_meet/jitsi_meet.dart';


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
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
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
}