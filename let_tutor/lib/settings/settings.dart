import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/settings/account_info.dart';
import 'package:let_tutor/settings/setting_feature.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  Settings(this.setLoginStatus, this.setSelectedIndex);

  final VoidCallback setLoginStatus;
  final void Function(int) setSelectedIndex;

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(setting.language == "English" ? 'Settings' : "Cài đặt", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: [
            AccountInfo(AssetImage('images/avatar.jpg'), 'April Corpuz', 'AprilCorpuz@gmail.com'),

            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  SettingFeature(Icon(Icons.account_box_outlined, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                setting.language == "English" ? 'View Feedbacks' : "Xem đánh giá bản thân",
                                Icon(Icons.navigate_next, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                () { Navigator.pushNamed(context, "/feedback_list"); },),
                  SettingFeature(Icon(Icons.list_alt_outlined, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                setting.language == "English" ? 'Booking History' : "Lịch sử đặt lịch",
                                Icon(Icons.navigate_next, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                () { Navigator.pushNamed(context, "/booking_history"); },),
                  SettingFeature(Icon(Icons.timelapse_outlined, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                setting.language == "English" ? 'Session History' : "Lịch sử học",
                                Icon(Icons.navigate_next, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                () { Navigator.pushNamed(context, "/session_history"); },),
                  SettingFeature(Icon(Icons.settings_outlined, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                setting.language == "English" ? 'Advanced Settings' : "Cài đặt nâng cao", 
                                Icon(Icons.navigate_next, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                () { Navigator.pushNamed(context, "/advanced_settings"); },),
                ],
              )
            ),

            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  SettingFeature(Icon(Icons.web_outlined, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                setting.language == "English" ? 'Our Website' : "Đi đến Website",
                                Icon(Icons.navigate_next, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                () {},),
                  SettingFeature(Icon(Icons.facebook_outlined, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                'Facebook', 
                                Icon(Icons.navigate_next, color: setting.theme == "White" ? Colors.black : Colors.white,),
                                () {},),
                ],
              )
            ),

            Container(
              margin: const EdgeInsets.only(top: 10, right: 20),
              child: Text(
                setting.language == "English" ? 'Version 1.1.0' : "Phiên bản 1.1.0",
                textAlign: TextAlign.end,
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              )
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Button(setting.language == "English" ? 'Log out' : "Đăng xuất", () async{
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('accessToken');
                setLoginStatus();
                setSelectedIndex(0);
              }),
            ),
          ],
        ),
      )
    );
  }
}