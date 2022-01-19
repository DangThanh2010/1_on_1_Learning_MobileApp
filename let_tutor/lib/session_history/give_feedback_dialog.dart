
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class GiveFeedbackDialog extends StatefulWidget{
  GiveFeedbackDialog(this.name, this.idTutor, this.idBooking);

  final String name;
  final String idTutor;
  final String idBooking;

  @override
  _GiveFeedbackDialogState createState() => _GiveFeedbackDialogState(name, idTutor, idBooking);

}

class _GiveFeedbackDialogState extends State<GiveFeedbackDialog>{
  _GiveFeedbackDialogState(this.name, this.idTutor, this.idBooking);

  final String name;
  final String idTutor;
  final String idBooking;
  
  int star = 1;
  String feedback = "";

  Future<int> comment() async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.post(Uri.parse(APILINK + "user/feedbackTutor"),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
      },
      body: jsonEncode({
        "bookingId": idBooking,
        "userId": idTutor,
        "rating": star,
        "content": feedback
      }));
    return (res.statusCode);
  }

  Widget setupContent(context, Setting setting) {
    return 
      Container(
        color: setting.theme == "White" ? Colors.white : Colors.grey[800],
        height: 300,
        width: 300, 
        child: ListView(
          children: [
            SelectedInput(setting.language == "English" ? 'How many stars do you give for tutor?' : 'Bạn muốn đánh giá bao nhiêu sao cho gia sư?', 
                        setting.language == "English" ? 'Number of star' : 'Số sao', (String value) { 
                          setState(() {
                            star = int.parse(value);
                          });
                        }, ['1', '2', '3', '4', '5']),
            TextInput(setting.language == "English" ? 'Feedback' : 'Đánh giá',
                     setting.language == "English" ? 'Feedback' : 'Đánh giá', false, TextInputType.text, (String value){
                       setState(() {
                         feedback = value;
                       });
                     }),

            Button(setting.language == "English" ? 'Give Feedback' : 'Gửi đánh giá', () {
              comment();
              Navigator.pop(context);

            })
          ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return AlertDialog(
      backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
      title: Center(
        child: Text(setting.language == "English" ? 'Give feedback for ' + name : "Gửi đánh giá về " + name,
                    style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)),
      ),
      content: setupContent(context, setting),
    );
  }
}