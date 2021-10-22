import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';

class GiveFeedbackDialog extends StatelessWidget{
  GiveFeedbackDialog(this.name);

  final String name;

  Widget setupContent(context) {
    return 
      Container(
        color: Colors.white,
        height: 300,
        width: 300, 
        child: ListView(
          children: [
            SelectedInput('How many stars do you give for tutor?', 'Number of star', (String value) {}, ['1', '2', '3', '4', '5']),
            TextInput('Feedback', 'Feedback', false, TextInputType.text, (String value){}),

            Button('Give Feedback', () {
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
        child: Text('Give feedback for ' + name),
      ),
      content: setupContent(context),
    );
  }
}