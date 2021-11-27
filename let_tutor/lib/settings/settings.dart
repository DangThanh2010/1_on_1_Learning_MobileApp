import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/settings/account_info.dart';
import 'package:let_tutor/settings/setting_feature.dart';

class Settings extends StatelessWidget {
  Settings(this.setLoginStatus, this.setSelectedIndex);

  final VoidCallback setLoginStatus;
  final void Function(int) setSelectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            AccountInfo(AssetImage('images/avatar.jpg'), 'April Corpuz', 'AprilCorpuz@gmail.com'),

            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  SettingFeature(Icon(Icons.account_box_outlined), 'View Feedbacks', Icon(Icons.navigate_next),() { Navigator.pushNamed(context, "/feedback_list"); },),
                  SettingFeature(Icon(Icons.list_alt_outlined), 'Booking History', Icon(Icons.navigate_next),() { Navigator.pushNamed(context, "/booking_history"); },),
                  SettingFeature(Icon(Icons.timelapse_outlined), 'Session History', Icon(Icons.navigate_next),() { Navigator.pushNamed(context, "/session_history"); },),
                  SettingFeature(Icon(Icons.settings_outlined), 'Advanced Settings', Icon(Icons.navigate_next),() { Navigator.pushNamed(context, "/advanced_settings"); },),
                ],
              )
            ),

            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  SettingFeature(Icon(Icons.web_outlined), 'Our Website', Icon(Icons.navigate_next),() {},),
                  SettingFeature(Icon(Icons.facebook_outlined), 'Facebook', Icon(Icons.navigate_next),() {},),
                ],
              )
            ),

            Container(
              margin: const EdgeInsets.only(top: 10, right: 20),
              child: Text(
                'Version 1.1.0',
                textAlign: TextAlign.end,
              )
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Button('Log out', (){
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