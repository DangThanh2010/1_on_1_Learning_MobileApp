import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/check_box.dart';
import 'package:let_tutor/global_widget/date_input.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';


class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Center(
              child: Container(
                height: 90,
                width: 90,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/avatar.jpg'),
                          )
                        ),
                      )
                    ),

                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 15,
                          onPressed: () {},
                          icon: Icon(Icons.camera_alt, color: Colors.white,)
                        )
                      )
                    )
                  ]
                ),
              )
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text('April Corpuz', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text('AprilCorpuz@gmail.com', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),),
              ),
            ),

            TextInput('Full name', 'Full name', false, TextInputType.text, (String value){}),
            DateInput('Birthday', 'Birthday', false, (String value){}),
            TextInput('Phone number', 'Phone number', false, TextInputType.number, (String value){}),
            SelectedInput('Country', 'Country', (String value){}, ['Vietnam', 'Japan', 'Korean', 'Thailand']),
            SelectedInput('My level', 'My level', (String value){}, ['Beginner', 'Intermediate', 'Advanced']),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 

                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Want to learn',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ),
                  CheckBox('English for Kids', (String title){}),
                  CheckBox('Business English', (String title){}),
                  CheckBox('Conversational English',(String title){}),
                  CheckBox('TOEIC',(String title){}),
                  CheckBox('TOEFL',(String title){}),
                  CheckBox('IELTS',(String title){}),
                  CheckBox('PET',(String title){}),
                  CheckBox('KET',(String title){}),
                ]
              )
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Button('Save', () { Navigator.pop(context);}),
            )
          ],
        ),
      )
    );
  }
}

