import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/check_box.dart';
import 'package:let_tutor/become_a_tutor/part_name.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/date_input.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';

class BecomeATutor extends StatefulWidget {
  @override
  _BecomeATutorState createState() => _BecomeATutorState();
}

class _BecomeATutorState extends State<BecomeATutor>{
  String name = "";
  String country = "";
  String birthDay = "";
  String interestes = "";
  String education = "";
  String experience = "";
  String profession = "";
  String languages = "";
  String introduction = "";
  String level = "";
  List<String> specialties = <String>[];

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
              
            TextInput("Tutor's name", "Tutor's name", false, TextInputType.text, (String value){setState(() {
              name = value;
            });}),
            SelectedInput("I'm from", 'Country', (String value){ setState(() {
              country = value;
            });},['Vietnam', 'Japan', 'Korean', 'Thailand']),
            DateInput('Date of Birth', 'Birthday', false, (String value){ setState(() {
              birthDay = value;
            });}),

            PartName('CV'),

            TextInput("Interests", "Interestes", false, TextInputType.text, (String value){setState(() {
              interestes = value;
            });}),
            TextInput("Education", "Education", false, TextInputType.text, (String value){setState(() {
              education = value;
            });}),
            TextInput("Experience", "Experience", false, TextInputType.text, (String value){setState(() {
              experience = value;
            });}),
            TextInput("Current or Previous Profession", "Current or Previous Profession", false, TextInputType.text, (String value){setState(() {
              profession = value;
            });}),

            PartName('Languages I speak'),
            TextInput("Languages", "Languages", false, TextInputType.text, (String value){setState(() {
              languages = value;
            });}),

            PartName('Who I teach'),
            TextInput("Introduction", "Introduction", false, TextInputType.text, (String value){setState(() {
              introduction = value;
            });}),

            SelectedInput('I am best at teaching students who are', 'Level', (String value){setState(() {
              level = value;
            });}, ['Beginner', 'Intermediate', 'Advanced']),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text('My specialties are', style: TextStyle(fontWeight: FontWeight.bold),)
            ),

            CheckBox('English for Kids',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox('Business English',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox('Conversational English',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox('TOEIC',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox('TOEFL',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox('IELTS', (String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox('PET',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox('KET',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),

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
              child: Button('Submit', () {Navigator.pop(context);}),
            )
          ],
        ),
      )
    );
  }
}