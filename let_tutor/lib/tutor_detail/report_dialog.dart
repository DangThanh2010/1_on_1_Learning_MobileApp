import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/check_box.dart';
import 'package:let_tutor/global_widget/text_input.dart';

class ReportDialog extends StatelessWidget{
  ReportDialog(this.name);

  final String name;

  Widget setupContent(context) {
    return 
      Container(
        color: Colors.white,
        height: 400,
        width: 300, 
        child: ListView(
          children: [
            Text("Help us understand what's happening", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
            CheckBox('This tutor is annoying me', (String value) {}, (String value) {}),
            CheckBox('This profile is pretending be someone or is fake', (String value) {}, (String value) {}),
            CheckBox('Inappropriate profile photo', (String value) {}, (String value) {}),
            TextInput('Other', 'Other reasons', false, TextInputType.text, (String value){}),

            Button('Report', () {
              Navigator.pop(context);
            })
          ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Report ' + name),
      ),
      content: setupContent(context),
    );
  }
}