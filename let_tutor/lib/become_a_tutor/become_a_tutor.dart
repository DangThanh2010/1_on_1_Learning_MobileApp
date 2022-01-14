import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/check_box.dart';
import 'package:let_tutor/become_a_tutor/part_name.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/date_input.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

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
    Setting setting = context.watch<Setting>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: setting.theme == "White" ? Colors.black : Colors.white
        ),
        title: Text(setting.language == "English" ? 'Become a tutor' : "Trở thành gia sư", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: [
            PartName(setting.language == "English" ? 'Basic info' : "Thông tin cơ bản"),

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
                  child: Center(
                    child: Text(
                      setting.language == "English" ? 'Upload avatar here...' : "Đăng tải ảnh ở đây...",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                    )
                  ),
                )
              )
            ),
              
            TextInput(setting.language == "English" ? "Tutor's name" : "Họ tên", setting.language == "English" ? "Tutor's name" : "Họ tên", false, TextInputType.text, (String value){setState(() {
              name = value;
            });}),
            SelectedInput(setting.language == "English" ? "I'm from" : "Tôi đến từ", setting.language == "English" ? "Country" : "Quốc gia", (String value){ setState(() {
              country = value;
            });},['Vietnam', 'Japan', 'Korean', 'Thailand']),
            DateInput(setting.language == "English" ? "Date of Birth" : "Ngày sinh", setting.language == "English" ? "Date of Birth" : "Ngày sinh", false, (String value){ setState(() {
              birthDay = value;
            });}),

            PartName('CV'),

            TextInput(setting.language == "English" ? "Interestes" : "Sở thích", setting.language == "English" ? "Interestes" : "Sở thích", false, TextInputType.text, (String value){setState(() {
              interestes = value;
            });}),
            TextInput(setting.language == "English" ? "Education" : "Học vấn", setting.language == "English" ? "Education" : "Học vấn", false, TextInputType.text, (String value){setState(() {
              education = value;
            });}),
            TextInput(setting.language == "English" ? "Experience" : "Kinh nghiệm", setting.language == "English" ? "Experience" : "Kinh nghiệm" , false, TextInputType.text, (String value){setState(() {
              experience = value;
            });}),
            TextInput(setting.language == "English" ? "Current or Previous Profession" : "Nghề nghiệp", setting.language == "English" ? "Current or Previous Profession" : "Nghề nghiệp", false, TextInputType.text, (String value){setState(() {
              profession = value;
            });}),

            PartName(setting.language == "English" ? 'Languages I speak' : "Ngôn ngữ mà tôi nói"),
            TextInput(setting.language == "English" ? "Languages" : "Ngôn ngữ", setting.language == "English" ? "Languages" : "Ngôn ngữ", false, TextInputType.text, (String value){setState(() {
              languages = value;
            });}),

            PartName(setting.language == "English" ? 'Who I teach' : "Đối tượng giảng dạy"),
            TextInput(setting.language == "English" ? "Introduction" : "Giới thiệu", setting.language == "English" ? "Introduction" : "Giới thiệu", false, TextInputType.text, (String value){setState(() {
              introduction = value;
            });}),

            SelectedInput(setting.language == "English" ? 'I am best at teaching students who are' : "Tôi sẽ giảng dạy tốt nhất ở trình độ", setting.language == "English" ? 'Level' : "Trình độ", (String value){setState(() {
              level = value;
            });}, ['Beginner', 'Intermediate', 'Advanced']),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(setting.language == "English" ? 'My specialties are' : "Chuyên môn của tôi là", style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),)
            ),

            CheckBox(false,'English for Kids',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox(false,'Business English',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox(false,'Conversational English',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox(false,'TOEIC',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox(false,'TOEFL',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox(false,'IELTS', (String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox(false,'PET',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),
            CheckBox(false,'KET',(String title){ setState(() {
              specialties.add(title);
            });}, (String title) { setState(() {
              specialties.remove(title);
            });}),

            PartName(setting.language == "English" ? 'Video introduce' : "Video giới thiệu"),

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
                  child: Center(
                    child: Text(
                      setting.language == "English" ? 'Upload video here...': "Đăng tải video ở đây...",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                    )
                  ),
                )
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Button(setting.language == "English" ? 'Submit': "Gửi", () {Navigator.pop(context);}),
            )
          ],
        ),
      )
    );
  }
}