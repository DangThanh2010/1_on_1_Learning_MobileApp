import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/check_box.dart';
import 'package:let_tutor/global_widget/date_input.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';


class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: setting.theme == "White" ? Colors.black : Colors.white
        ),
        title: Text(setting.language == "English" ? 'Profile' : "Hồ sơ", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: [
            Center(
              child: SizedBox(
                height: 90,
                width: 90,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
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
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 15,
                          onPressed: () {},
                          icon: const Icon(Icons.camera_alt, color: Colors.white,)
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
                child: Text('April Corpuz', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: setting.theme == "White" ? Colors.grey : Colors.white),),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text('AprilCorpuz@gmail.com', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: setting.theme == "White" ? Colors.grey : Colors.white),),
              ),
            ),

            TextInput(setting.language == "English" ? 'Full name' : 'Họ tên', setting.language == "English" ? 'Full name' : 'Họ tên', false, TextInputType.text, (String value){}),
            DateInput(setting.language == "English" ? 'Birthday' : 'Ngày sinh', setting.language == "English" ? 'Birthday' : 'Ngày sinh', false, (String value){}),
            TextInput(setting.language == "English" ? 'Phone number' : 'Số điện thoại', setting.language == "English" ? 'Phone number' : 'Số điện thoại', false, TextInputType.number, (String value){}),
            SelectedInput(setting.language == "English" ? 'Country' : 'Quốc gia', setting.language == "English" ? 'Country' : 'Quốc gia', (String value){}, ['Vietnam', 'Japan', 'Korean', 'Thailand']),
            SelectedInput(setting.language == "English" ? 'My level' : 'Trình độ', setting.language == "English" ? 'My level' : 'Trình độ', (String value){}, ['Beginner', 'Intermediate', 'Advanced']),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 

                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      setting.language == "English" ? 'Want to learn' : 'Muốn học',
                      style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),
                    )
                  ),
                  CheckBox('English for Kids', (String title){}, (String title){}),
                  CheckBox('Business English', (String title){}, (String title){}),
                  CheckBox('Conversational English',(String title){}, (String title){}),
                  CheckBox('TOEIC',(String title){}, (String title){}),
                  CheckBox('TOEFL',(String title){}, (String title){}),
                  CheckBox('IELTS',(String title){}, (String title){}),
                  CheckBox('PET',(String title){}, (String title){}),
                  CheckBox('KET',(String title){}, (String title){}),
                ]
              )
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Button(setting.language == "English" ? 'Save' : 'Lưu', () { Navigator.pop(context);}),
            )
          ],
        ),
      )
    );
  }
}

