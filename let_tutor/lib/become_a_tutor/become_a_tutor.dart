import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/global_widget/check_box.dart';
import 'package:let_tutor/become_a_tutor/part_name.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/country_list_pick.dart';
import 'package:let_tutor/global_widget/date_input.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class BecomeATutor extends StatefulWidget {
  @override
  _BecomeATutorState createState() => _BecomeATutorState();
}

class _BecomeATutorState extends State<BecomeATutor>{

  FilePickerResult? image = null;
  FilePickerResult? video = null;
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

  void register () async{
    if (image != null && video != null) {
      PlatformFile fileImage = image!.files.first;
      PlatformFile fileVideo = video!.files.first;

      final prefs = await SharedPreferences.getInstance();
      Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

      var request = http.MultipartRequest('PUT', Uri.parse(APILINK + "tutor/register"));
      Map<String, String> headers= <String,String>{
        "Content-Type": "multipart/form-data",
        'Authorization':'Bearer ' + (access.token ?? '0'),

      };
      request.headers.addAll(headers);
      request.files.add(
        await http.MultipartFile.fromPath(
          'avatar',
          fileImage.path ?? "",
        )
      );
       request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          fileVideo.path ?? "",
        )
      );

      String spes = "";
      specialties.map((e) => spes += e);

      request.fields.addAll({
        "name": name,
        "country": country,
        "birthday": birthDay,
        "interests": interestes,
        "education": education,
        "experience": experience,
        "profession": profession,
        "languages": languages,
        "bio": introduction,
        "targetStudent": level,
        "specialties": spes,
        "price": "50000"
      });

      await request.send();
    }
  }
  

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
              onTap: () async{
                FilePickerResult? res = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
                setState(() {
                  image = res;
                });
              },
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
                      setting.language == "English" ? (image == null ? 'Upload avatar here...' : 'Uploaded'): (image == null ? "Đăng tải ảnh ở đây..." : "Đã chọn ảnh"),
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
            CountryListPickWidget("VN", setting.language == "English" ? "I'm from" : "Tôi đến từ", (String value){ setState(() {
              country = value;
            });}),
           
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
            });}, ['BEGINNER', "HIGHER_BEGINNER", "PRE_INTERMEDIATE",  "INTERMEDIATE", "UPPER_INTERMEDIATE", "ADVANCED", "PROFICIENCY"]),

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
              onTap: () async{
                FilePickerResult? res  = await FilePicker.platform.pickFiles(type: FileType.video, withData: true);
                setState(() {
                  video = res;
                });
              },
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
                      setting.language == "English" ? (video == null ? 'Upload video here...' : "Uploaded"): (video == null ? "Đăng tải video ở đây..." : "Đã chọn video"),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                    )
                  ),
                )
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Button(setting.language == "English" ? 'Submit': "Gửi", () {
                register();
                Navigator.pop(context);
              }),
            )
          ],
        ),
      )
    );
  }
}