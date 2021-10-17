import 'package:flutter/material.dart';
import 'package:let_tutor/become_a_tutor/check_box.dart';
import 'package:let_tutor/become_a_tutor/input_box_2.dart';
import 'package:let_tutor/become_a_tutor/part_name.dart';
import 'package:let_tutor/become_a_tutor/radio_button_level.dart';
import 'package:let_tutor/global_widget/button.dart';

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
              
            InputBox2('Tutoring name'),
            InputBox2("I'm from"),
            InputBox2('Date of Birth'),

            PartName('CV'),

            InputBox2('Interests'),
            InputBox2('Education'),
            InputBox2('Experience'),
            InputBox2('Current or Previous Profession'),

            PartName('Languages I speak'),
            InputBox2('Languages'),

            PartName('Who I teach'),
            InputBox2('Introduction'),

            RadioButtonLevel(),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text('My specialties are')
            ),

            CheckBox('English for Kids'),
            CheckBox('Business English'),
            CheckBox('Conversational English'),
            CheckBox('TOEIC'),
            CheckBox('TOEFL'),
            CheckBox('IELTS'),
            CheckBox('PET'),
            CheckBox('KET'),

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
              margin: const EdgeInsets.only(bottom: 30),
              child: Button('Submit', () {}),
            )
          ],
        ),
      )
    );
  }
}