import 'package:flutter/material.dart';
import 'package:let_tutor/advanced_settings/advanced_settings.dart';
import 'package:let_tutor/authentication/forgot_password.dart';
import 'package:let_tutor/authentication/sign_in.dart';
import 'package:let_tutor/authentication/sign_up.dart';
import 'package:let_tutor/become_a_tutor/become_a_tutor.dart';
import 'package:let_tutor/booking_history/booking_history.dart';
import 'package:let_tutor/course_detail/course_detail.dart';
import 'package:let_tutor/courses/courses.dart';
import 'package:let_tutor/data/data.dart';
import 'package:let_tutor/feedback_list/feedback_list.dart';
import 'package:let_tutor/home/home.dart';
import 'package:let_tutor/message/message.dart';
import 'package:let_tutor/message_detail/message_detail.dart';
import 'package:let_tutor/model/course_dto.dart';
import 'package:let_tutor/model/feedback_dto.dart';
import 'package:let_tutor/model/language_dto.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/list_comment_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/specialty_dto.dart';
import 'package:let_tutor/model/topic_dto.dart';
import 'package:let_tutor/profile/profile.dart';
import 'package:let_tutor/session_history/session_history.dart';
import 'package:let_tutor/settings/settings.dart';
import 'package:let_tutor/tutor_detail/tutor_detail.dart';
import 'package:let_tutor/tutors/tutors.dart';
import 'package:let_tutor/upcoming/upcoming.dart';
import 'package:let_tutor/video_conference/video_conference.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget{
  final ListTutorDTO listTutor = listTutorDTO;
  final ListCommentDTO listComment = listCommentDTO;
  final ListBookingDTO listBooking = listBookingDTO;
  final List<LanguageDTO> listLanguage = listLanguageDTO;
  final List<SpecialtyDTO> listSpecialty = listSpecialtyDTO;
  final List<CourseDTO> listCourse = listCourseDTO;
  final List<TopicDTO> listTopic = listTopicDTO;
  final List<FeedbackDTO> listFeedback = listFeedbackDTO;

  @override
  Widget build(BuildContext context) {
    listBooking.list.sort((a, b) => a.start.compareTo(b.start));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => listTutor),
        ChangeNotifierProvider(create: (context) => listComment),
        ChangeNotifierProvider(create: (context) => listBooking),
        Provider(create: (context) => listLanguage),
        Provider(create: (context) => listSpecialty),
        Provider(create: (context) => listCourse),
        Provider(create: (context) => listTopic),
        Provider(create: (context) => listFeedback),
      ],
      child: MaterialApp(
        title: "Let Tutor",
        debugShowCheckedModeBanner: false,
        routes: {
          "/forgot_password": (context) => SafeArea(child: ForgotPassword()),
          "/sign_up": (context) => SafeArea(child: SignUp()),
          "/profile": (context) => SafeArea(child: Profile()),
          "/video_conference": (context) => SafeArea(child: VideoCoference()),
          "/become_a_tutor": (context) => SafeArea(child: BecomeATutor()),
          "/feedback_list": (context) => SafeArea(child: FeedbackList()),
          "/booking_history": (context) => SafeArea(child: BookingHistory()),
          "/session_history": (context) => SafeArea(child: SessionHistory()),
          "/advanced_settings": (context) => SafeArea(child: AdvancedSettings("English")),
        },
        home: SafeArea(
          child: MyApp(),
        ),
      )
    );
  }
  
}

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

  Widget displayScreen() {
    if(!isLogin){
      return SignIn(setLoginStatus);
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