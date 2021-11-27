import 'package:flutter/material.dart';
import 'package:let_tutor/advanced_settings/advanced_settings.dart';
import 'package:let_tutor/authentication/forgot_password.dart';
import 'package:let_tutor/authentication/sign_in.dart';
import 'package:let_tutor/authentication/sign_up.dart';
import 'package:let_tutor/become_a_tutor/become_a_tutor.dart';
import 'package:let_tutor/booking_history/booking_history.dart';
import 'package:let_tutor/course_detail/course_detail.dart';
import 'package:let_tutor/courses/courses.dart';
import 'package:let_tutor/feedback_list/feedback_list.dart';
import 'package:let_tutor/home/home.dart';
import 'package:let_tutor/message/message.dart';
import 'package:let_tutor/message_detail/message_detail.dart';
import 'package:let_tutor/profile/profile.dart';
import 'package:let_tutor/session_history/session_history.dart';
import 'package:let_tutor/settings/settings.dart';
import 'package:let_tutor/tutor_detail/tutor_detail.dart';
import 'package:let_tutor/tutors/tutors.dart';
import 'package:let_tutor/upcoming/upcoming.dart';
import 'package:let_tutor/video_conference/video_conference.dart';

void main() {
  runApp(MaterialApp(
    title: "Let Tutor",
    debugShowCheckedModeBanner: false,
    home: SafeArea(
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  int isLogin = 1;
  int selectedIndex = 0;

  Widget displayScreenWhenLoggedIn(){
    if(selectedIndex == 0){
      return Home();
    }
    else if(selectedIndex == 1){
      return Message();
    }
    else if(selectedIndex == 2){
      return Upcoming();
    }
    else if(selectedIndex == 3){
      return Tutors();
    }
    else if(selectedIndex == 4){
      return Courses();
    }
    else {
      return Settings();
    }
  }

  Widget displayScreen() {
    if(isLogin == 0){
      return SignIn();
    }
    else {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Tutor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: displayScreenWhenLoggedIn(),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return displayScreen();
  }
}