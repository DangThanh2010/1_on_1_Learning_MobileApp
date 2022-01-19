import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:let_tutor/config.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/check_box.dart';
import 'package:let_tutor/global_widget/country_list_pick.dart';
import 'package:let_tutor/global_widget/date_input.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';

import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:let_tutor/model/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
  
}

class _ProfileState extends State<Profile>{

  String name = "";
  String birthday = "";
  String phone = "";
  String country = "";
  String level = "";
  List<String> learnTopics = [];
  List<String> testPreparations = [];

  bool isLoading = false;

  Future<User> fetchUser () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.get(Uri.parse(APILINK + "user/info"),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                });
    if(res.statusCode == 200){
      var user = User.fromJson(jsonDecode(res.body)['user']); 
      return user;
    }else {
      return User();
    }
  }

  List<int> getLearnTopic(user) {
    List<int> result = [];
    for(var i = 0; i < user.learnTopics.length; i++){
      result.add(user.learnTopics[i].id);
    }
    return result;
  }

  List<int> getTestPreparations(user) {
    List<int> result = [];
    for(var i = 0; i < user.testPreparations.length; i++){
      result.add(user.testPreparations[i].id);
    }
    return result;
  }

  void updateUser (name, birthday, phone, country, level, learnTopics, testPreparations) async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    await http.put(Uri.parse(APILINK + "user/info"),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
      },
      body: jsonEncode({
        "name": name,
        "country": country,
        "phone": phone,
        "birthday": birthday,
        "level": level,
        "learnTopics": learnTopics,
        "testPreparations":testPreparations
      }));
    
    setState(() {
      isLoading = !isLoading;
    });
  }

  void updateAvatar () async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);

    if (result != null) {
      PlatformFile file = result.files.first;

      final prefs = await SharedPreferences.getInstance();
      Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

      var request = http.MultipartRequest('POST', Uri.parse(APILINK + "user/uploadAvatar"));
      Map<String, String> headers= <String,String>{
        "Content-Type": "multipart/form-data",
        'Authorization':'Bearer ' + (access.token ?? '0'),

      };
      request.headers.addAll(headers);
      request.files.add(
        await http.MultipartFile.fromPath(
          'avatar',
          file.path ?? "",
        )
      );

      await request.send();
      setState(() {
        isLoading = !isLoading;
      });
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
        title: Text(setting.language == "English" ? 'Profile' : "Hồ sơ", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: FutureBuilder<User>(
          future: isLoading ? fetchUser() : fetchUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Center(
                  child: CircularProgressIndicator()
                )
              );
            }
            if (snapshot.hasData) {
              if(snapshot.data.id == null){
                return Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(setting.language == "English" ? 'Error.' : 'Đã xảy ra lỗi.',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                                color: setting.theme == "White" ? Colors.black : Colors.white, ),)
                  )
                );
              }
              learnTopics.addAll(getLearnTopic(snapshot.data).map((e) => e.toString()));
              testPreparations.addAll(getTestPreparations(snapshot.data).map((e) => e.toString()));
              name = snapshot.data.name ?? "";
              birthday = snapshot.data.birthday ?? "";
              phone = snapshot.data.phone ?? "";
              country  =snapshot.data.country ?? "";
              level = snapshot.data.level ?? "";
              return (ListView(
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
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:   NetworkImage(snapshot.data.avatar == "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png" ? "https://res.cloudinary.com/dangthanh/image/upload/v1641804706/AvatarEtutor/user_ryrffo.png" : snapshot.data.avatar),
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
                                onPressed: () {updateAvatar();},
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
                      child: Text(snapshot.data.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: setting.theme == "White" ? Colors.grey : Colors.white),),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text(snapshot.data.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: setting.theme == "White" ? Colors.grey : Colors.white),),
                    ),
                  ),

                  TextInput(setting.language == "English" ? 'Full name' : 'Họ tên', snapshot.data.name ?? "", false, TextInputType.text, (String value){ name = value;}),
                  DateInput(setting.language == "English" ? 'Birthday' : 'Ngày sinh', snapshot.data.birthday ?? "" , false, (String value){birthday = value;}),
                  TextInput(setting.language == "English" ? 'Phone number' : 'Số điện thoại', snapshot.data.phone ?? "", false, TextInputType.number, (String value){ phone = value;}),
                  
                  CountryListPickWidget(snapshot.data.country ?? "VN" , setting.language == "English" ? 'Country' : 'Quốc gia', (String value){country = value;}),
                  SelectedInput(setting.language == "English" ? 'My level' : 'Trình độ', snapshot.data.level ?? "BEGINNER", (String value){ level = value;}, ['BEGINNER', "HIGHER_BEGINNER", "PRE_INTERMEDIATE",  "INTERMEDIATE", "UPPER_INTERMEDIATE", "ADVANCED", "PROFICIENCY"]),

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
                        CheckBox(getLearnTopic(snapshot.data).contains(3), 'English for Kids', (String title){
                          if(!learnTopics.contains("3")){
                            learnTopics.add("3");
                          }
                        }, (String title){
                          if(learnTopics.contains("3")){
                            learnTopics.remove("3");
                          }
                        }),
                        CheckBox(getLearnTopic(snapshot.data).contains(4),'Business English', (String title){
                          if(!learnTopics.contains("4")){
                            learnTopics.add("4");
                          }
                        }, (String title){
                          if(learnTopics.contains("4")){
                            learnTopics.remove("4");
                          }
                        }),
                        CheckBox(getLearnTopic(snapshot.data).contains(5),'Conversational English',(String title){
                          if(!learnTopics.contains("5")){
                            learnTopics.add("5");
                          }
                        }, (String title){
                          if(learnTopics.contains("5")){
                            learnTopics.remove("5");
                          }
                        }),
                        
                        CheckBox(getTestPreparations(snapshot.data).contains(1), 'STATERS',(String title){
                          if(!testPreparations.contains("1")){
                            testPreparations.add("1");
                          }
                        }, (String title){
                          if(testPreparations.contains("1")){
                            testPreparations.remove("1");
                          }
                        }),
                        CheckBox(getTestPreparations(snapshot.data).contains(2), 'MOVERS',(String title){
                          if(!testPreparations.contains("2")){
                            testPreparations.add("2");
                          }
                        }, (String title){
                          if(testPreparations.contains("2")){
                            testPreparations.remove("2");
                          }
                        }),
                        CheckBox(getTestPreparations(snapshot.data).contains(3), 'FLYERS',(String title){
                          if(!testPreparations.contains("3")){
                            testPreparations.add("3");
                          }
                        }, (String title){
                          if(testPreparations.contains("3")){
                            testPreparations.remove("3");
                          }
                        }),
                        CheckBox(getTestPreparations(snapshot.data).contains(4), 'KET',(String title){
                          if(!testPreparations.contains("4")){
                            testPreparations.add("4");
                          }
                        }, (String title){
                          if(testPreparations.contains("4")){
                            testPreparations.remove("4");
                          }
                        }),
                        CheckBox(getTestPreparations(snapshot.data).contains(5), 'PET',(String title){
                          if(!testPreparations.contains("5")){
                            testPreparations.add("5");
                          }
                        }, (String title){
                          if(testPreparations.contains("5")){
                            testPreparations.remove("5");
                          }
                        }),
                        CheckBox(getTestPreparations(snapshot.data).contains(6), 'IELTS',(String title){
                          if(!testPreparations.contains("6")){
                            testPreparations.add("6");
                          }
                        }, (String title){
                          if(testPreparations.contains("6")){
                            testPreparations.remove("6");
                          }
                        }),
                        CheckBox(getTestPreparations(snapshot.data).contains(7), 'TOEFL',(String title){
                          if(!testPreparations.contains("7")){
                            testPreparations.add("7");
                          }
                        }, (String title){
                          if(testPreparations.contains("7")){
                            testPreparations.remove("7");
                          }
                        }),
                        CheckBox(getTestPreparations(snapshot.data).contains(8), 'TOEIC',(String title){
                          if(!testPreparations.contains("8")){
                            testPreparations.add("8");
                          }
                        }, (String title){
                          if(testPreparations.contains("8")){
                            testPreparations.remove("8");
                          }
                        }), 
                      ]
                    )
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Button(setting.language == "English" ? 'Save' : 'Lưu', () { updateUser(name, birthday, phone, country, level, learnTopics, testPreparations);}),
                  )
                ],
              ));
            }
            return Container();
          },
        ) 
      )
    );
  }
}

