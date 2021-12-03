import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class GiveFeedbackDialog extends StatelessWidget{
  GiveFeedbackDialog(this.name);

  final String name;

  Widget setupContent(context, Setting setting) {
    return 
      Container(
        color: setting.theme == "White" ? Colors.white : Colors.grey[800],
        height: 300,
        width: 300, 
        child: ListView(
          children: [
            SelectedInput(setting.language == "English" ? 'How many stars do you give for tutor?' : 'Bạn muốn đánh giá bao nhiêu sao cho gia sư?', 
                        setting.language == "English" ? 'Number of star' : 'Số sao', (String value) {}, ['1', '2', '3', '4', '5']),
            TextInput(setting.language == "English" ? 'Feedback' : 'Đánh giá',
                     setting.language == "English" ? 'Feedback' : 'Đánh giá', false, TextInputType.text, (String value){}),

            Button(setting.language == "English" ? 'Give Feedback' : 'Gửi đánh giá', () {
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