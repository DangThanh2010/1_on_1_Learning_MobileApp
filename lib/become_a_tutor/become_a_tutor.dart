import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/check_box.dart';
import 'package:let_tutor/become_a_tutor/part_name.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/date_input.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';

class BecomeATutor extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a tutor', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            PartName('Basic info'),

            GestureDetector(
              onTap: () {},
              child:  Center(
                child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue)
                  ),
                  child: const Center(
                    child: Text(
                      'Upload avatar here...',
                      textAlign: TextAlign.center,
                    )
                  ),
                )
              )
            ),
              
            TextInput("Tutor's name", "Tutor's name", false, TextInputType.text, (String value){}),
            SelectedInput("I'm from", 'Country', (String value){}, ['Vietnam', 'Japan', 'Korean', 'Thailand']),
            DateInput('Date of Birth', 'Birthday', false, (String value){}),

            PartName('CV'),

            TextInput("Interests", "Interestes", false, TextInputType.text, (String value){}),
            TextInput("Education", "Education", false, TextInputType.text, (String value){}),
            TextInput("Experience", "Experience", false, TextInputType.text, (String value){}),
            TextInput("Current or Previous Profession", "Current or Previous Profession", false, TextInputType.text, (String value){}),

            PartName('Languages I speak'),
            TextInput("Languages", "Languages", false, TextInputType.text, (String value){}),

            PartName('Who I teach'),
            TextInput("Introduction", "Introduction", false, TextInputType.text, (String value){}),

            SelectedInput('I am best at teaching students who are', 'Level', (String value){}, ['Beginner', 'Intermediate', 'Advanced']),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text('My specialties are', style: TextStyle(fontWeight: FontWeight.bold),)
            ),

            CheckBox('English for Kids',(String title){}),
            CheckBox('Business English',(String title){}),
            CheckBox('Conversational English',(String title){}),
            CheckBox('TOEIC',(String title){}),
            CheckBox('TOEFL',(String title){}),
            CheckBox('IELTS',(String title){}),
            CheckBox('PET',(String title){}),
            CheckBox('KET',(String title){}),

            PartName('Video introduce'),

            GestureDetector(
              onTap: () {},
              child: Center(
                child: Container(
                  width: 300,
                  height: 150,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue)
                  ),
                  child: const Center(
                    child: Text(
                      'Upload video here...',
                      textAlign: TextAlign.center,
                    )
                  ),
                )
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Button('Submit', () {}),
            )
          ],
        ),
      )
    );
  }
}