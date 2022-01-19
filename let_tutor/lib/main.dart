import 'package:flutter/material.dart';
import 'package:let_tutor/advanced_settings/advanced_settings.dart';
import 'package:let_tutor/authentication/forgot_password.dart';
import 'package:let_tutor/authentication/sign_up.dart';
import 'package:let_tutor/become_a_tutor/become_a_tutor.dart';
import 'package:let_tutor/feedback_list/feedback_list.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/myapp.dart';
import 'package:let_tutor/profile/profile.dart';
import 'package:let_tutor/session_history/session_history.dart';
import 'package:let_tutor/video_conference/video_conference.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget{
  App();
  

  @override
  Widget build(BuildContext context) {
    
    Setting setting = Setting("English", "White");
    SharedPreferences.getInstance().then((prefs){
      setting.language = prefs.getString('language') ?? "English";
      setting.theme = prefs.getString('theme') ?? "White";
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => setting),
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
          //"/feedback_list": (context) => SafeArea(child: FeedbackList()),
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