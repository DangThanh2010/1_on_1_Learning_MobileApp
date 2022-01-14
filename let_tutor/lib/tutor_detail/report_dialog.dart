import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/check_box.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class ReportDialog extends StatelessWidget{
  ReportDialog(this.name);

  final String name;

  Widget setupContent(context, Setting setting) {
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
                    (String value) {}, (String value) {}),
            CheckBox(false,setting.language == "English" ? 'This profile is pretending be someone or is fake' : "Hồ sơ này là giả mạo",
                    (String value) {}, (String value) {}),
            CheckBox(false,setting.language == "English" ? 'Inappropriate profile photo' : "Ảnh hồ sơ không phù hợp",
                    (String value) {}, (String value) {}),
            TextInput(setting.language == "English" ? 'Other' : "Lý do khác",
                    setting.language == "English" ? 'Other' : "Lý do khác",
                    false, TextInputType.text, (String value){}),

            Button(setting.language == "English" ? 'Report' : "Báo cáo", () {
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