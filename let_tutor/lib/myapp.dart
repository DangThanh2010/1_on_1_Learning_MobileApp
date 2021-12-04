import 'package:flutter/material.dart';
import 'package:let_tutor/authentication/sign_in.dart';
import 'package:let_tutor/courses/courses.dart';
import 'package:let_tutor/home/home.dart';
import 'package:let_tutor/message/message.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/settings/settings.dart';
import 'package:let_tutor/tutors/tutors.dart';
import 'package:let_tutor/upcoming/upcoming.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  int selectedIndex = 0;

  void setLoginStatus(){
    setState(() {
      isLogin = !isLogin;
    });
  }

  void setSelectedIndex(int value){
    setState(() {
      selectedIndex = value;
    });
  }

  Widget displayScreenWhenLoggedIn(){
    if(selectedIndex == 0){
      return Home(setSelectedIndex);
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
      return Settings(setLoginStatus, setSelectedIndex);
    }
  }

  Widget displayScreen(Setting setting) {
    if(!isLogin){
      return SignIn(setLoginStatus);
    }
    else {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: setting.language == "English" ? 'Home' : "Trang chủ",
              backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.message),
              label: setting.language == "English" ? 'Message' : "Tin nhắn",
              backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.access_time),
              label: setting.language == "English" ? 'Upcoming' : "Sắp diễn ra",
              backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.people),
              label: setting.language == "English" ? 'Tutors' : "Gia sư",
              backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.book),
              label: setting.language == "English" ? 'Courses' : "Khóa học",
              backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: setting.language == "English" ? 'Settings' : "Cài đặt",
              backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blue,
          showUnselectedLabels: true,
          unselectedItemColor: setting.theme == "White" ? Colors.grey : Colors.white,
          unselectedLabelStyle: TextStyle(color: setting.theme == "White" ? Colors.grey : Colors.white),
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
    Setting setting = context.watch<Setting>();
    return displayScreen(setting);
  }
}