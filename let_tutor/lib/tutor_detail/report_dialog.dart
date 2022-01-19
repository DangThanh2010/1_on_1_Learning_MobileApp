import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/check_box.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class ReportDialog extends StatelessWidget{
  ReportDialog(this.name, this.tutorId, this.callBack);

  final String name;
  final String tutorId;
  final void Function(String) callBack;

  Future<int> report(content) async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.post(Uri.parse(APILINK + "report"),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
      },
      body: jsonEncode({
        "content": content,
        "tutorId": tutorId
      }));
    return (res.statusCode);
  }


  Widget setupContent(context, Setting setting) {
    List<String> reasons = [];
    String reason = "";
    return 
      Container(
        color: setting.theme == "White" ? Colors.white : Colors.grey[800],
        height: 400,
        width: 300, 
        child: ListView(
          children: [
            Text(setting.language == "English" ? "Help us understand what's happening" : "Bạn đang gặp phải vấn đề gì",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
            CheckBox(false,setting.language == "English" ? 'This tutor is annoying me' : "Gia sư này làm phiền tôi",
                    (String value) {
                      if(!reasons.contains(value)){
                        reasons.add(value);
                      }
                    }, (String value) {
                      if(reasons.contains(value)){
                        reasons.remove(value);
                      }
                    }),
            CheckBox(false,setting.language == "English" ? 'This profile is pretending be someone or is fake' : "Hồ sơ này là giả mạo",
                    (String value) {
                      if(!reasons.contains(value)){
                        reasons.add(value);
                      }
                    }, (String value) {
                      if(reasons.contains(value)){
                        reasons.remove(value);
                      }
                    }),
            CheckBox(false,setting.language == "English" ? 'Inappropriate profile photo' : "Ảnh hồ sơ không phù hợp",
                    (String value) {
                      if(!reasons.contains(value)){
                        reasons.add(value);
                      }
                    }, (String value) {
                      if(reasons.contains(value)){
                        reasons.remove(value);
                      }
                    }),
            TextInput(setting.language == "English" ? 'Other' : "Lý do khác",
                    setting.language == "English" ? 'Other' : "Lý do khác",
                    false, TextInputType.text, (String value){
                      reason = value;
                    }),

            Button(setting.language == "English" ? 'Report' : "Báo cáo", () async{
              String content = "";
             
              for(int i =0; i < reasons.length; i++){
                content += (reasons[i] + "\n");
              }
              
              content += reason;

              int code = await report(content);
              if(code == 200){
                callBack(setting.language == "English" ? "Report successfully": "Báo cáo thành công");
              } else {
                callBack(setting.language == "English" ? "Report unsuccessfully": "Báo cáo thất bại");
              }

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
        child: Text(setting.language == "English" ? 'Report ' + name : "Báo cáo về " + name,
                    style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)),
      ),
      content: setupContent(context, setting),
    );
  }
}
