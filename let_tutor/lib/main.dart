import 'package:flutter/material.dart';
import 'package:let_tutor/advanced_settings/advanced_settings.dart';
import 'package:let_tutor/authentication/forgot_password.dart';
import 'package:let_tutor/authentication/sign_up.dart';
import 'package:let_tutor/become_a_tutor/become_a_tutor.dart';
import 'package:let_tutor/booking_history/booking_history.dart';
import 'package:let_tutor/data/data.dart';
import 'package:let_tutor/data_access/booking_dao.dart';
import 'package:let_tutor/data_access/comment_dao.dart';
import 'package:let_tutor/data_access/tutor_dao.dart';
import 'package:let_tutor/feedback_list/feedback_list.dart';
import 'package:let_tutor/model/booking_dto.dart';
import 'package:let_tutor/model/comment_dto.dart';
import 'package:let_tutor/model/feedback_dto.dart';
import 'package:let_tutor/model/language_dto.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/list_comment_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/schedule_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/specialty_dto.dart';
import 'package:let_tutor/model/tutor_dto.dart';
import 'package:let_tutor/myapp.dart';
import 'package:let_tutor/profile/profile.dart';
import 'package:let_tutor/session_history/session_history.dart';
import 'package:let_tutor/video_conference/video_conference.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TutorDAO tutorDAO = TutorDAO();
  CommentDAO commentDAO = CommentDAO();
  BookingDAO bookingDAO = BookingDAO();

  List<TutorDTO> _listTutor = await tutorDAO.getTutorList();
  ListTutorDTO listTutor;
  if(_listTutor.isNotEmpty){
    listTutor = ListTutorDTO(_listTutor); 
  }else{
    listTutor = listTutorDTO;
    for(int i = 0; i < listTutorDTO.list.length; i++){
      await tutorDAO.insert(listTutorDTO.list[i]);
    }
  }

  List<CommentDTO> _listComment = await commentDAO.getCommentList();
  ListCommentDTO listComment;
  if(_listComment.isNotEmpty){
    listComment = ListCommentDTO(_listComment);
  }else{
    listComment = listCommentDTO;
    for(int i = 0; i < listCommentDTO.list.length; i++){
      await commentDAO.insert(listCommentDTO.list[i]);
    }
  }

  List<BookingDTO> _listBooking = await bookingDAO.getBookingList();
  ListBookingDTO listBooking;
  if(_listBooking.isNotEmpty){
    listBooking = ListBookingDTO(_listBooking);
  }else{
    listBooking = listBookingDTO;
    for(int i = 0; i < listBookingDTO.list.length; i++){
      await bookingDAO.insert(listBookingDTO.list[i]);
    }
  }

  runApp(App(listTutor, listComment, listBooking));
}

class App extends StatelessWidget{
  App(this.listTutor, this.listComment, this.listBooking);
  
  final ListTutorDTO listTutor;
  final ListCommentDTO listComment;
  final ListBookingDTO listBooking;

  final List<LanguageDTO> listLanguage = listLanguageDTO;
  final List<SpecialtyDTO> listSpecialty = listSpecialtyDTO;
  final List<FeedbackDTO> listFeedback = listFeedbackDTO;
  final List<ScheduleDTO> listSchedule = listScheduleDTO;
  
  @override
  Widget build(BuildContext context) {
    listBooking.list.sort((a, b) => a.start.compareTo(b.start));
    listComment.list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    
    Setting setting = Setting("English", "White");
    SharedPreferences.getInstance().then((prefs){
      setting.language = prefs.getString('language') ?? "English";
      setting.theme = prefs.getString('theme') ?? "White";
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => listTutor),
        ChangeNotifierProvider(create: (context) => listComment),
        ChangeNotifierProvider(create: (context) => listBooking),
        ChangeNotifierProvider(create: (context) => setting),
        Provider(create: (context) => listLanguage),
        Provider(create: (context) => listSpecialty),
        Provider(create: (context) => listFeedback),
        Provider(create: (context) => listSchedule),
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
          "/advanced_settings": (context) => SafeArea(child: AdvancedSettings()),
        },
        home: SafeArea(
          child: MyApp(),
        ),
      )
    );
  }
}