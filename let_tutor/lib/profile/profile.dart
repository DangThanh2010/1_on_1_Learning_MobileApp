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


class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
  
}

class _ProfileState extends State<Profile>{

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
          future: fetchUser(),
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
                                  image: NetworkImage(snapshot.data.avatar),
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
                      child: Text(snapshot.data.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: setting.theme == "White" ? Colors.grey : Colors.white),),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text(snapshot.data.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: setting.theme == "White" ? Colors.grey : Colors.white),),
                    ),
                  ),

                  TextInput(setting.language == "English" ? 'Full name' : 'Họ tên', snapshot.data.name, false, TextInputType.text, (String value){}),
                  DateInput(setting.language == "English" ? 'Birthday' : 'Ngày sinh', snapshot.data.birthday , false, (String value){}),
                  TextInput(setting.language == "English" ? 'Phone number' : 'Số điện thoại', snapshot.data.phone, false, TextInputType.number, (String value){}),
                  //SelectedInput(setting.language == "English" ? 'Country' : 'Quốc gia', setting.language == "English" ? 'Country' : 'Quốc gia', (String value){}, ['Vietnam', 'Japan', 'Korean', 'Thailand']),
                  CountryListPickWidget(snapshot.data.country, setting.language == "English" ? 'Country' : 'Quốc gia', (String value){}),
                  SelectedInput(setting.language == "English" ? 'My level' : 'Trình độ', snapshot.data.level, (String value){}, ['BEGINNER', "HIGHER_BEGINNER", "PRE_INTERMEDIATE",  "INTERMEDIATE", "UPPER_INTERMEDIATE", "ADVANCED", "PROFICIENCY"]),

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
                        CheckBox(getLearnTopic(snapshot.data).contains(3), 'English for Kids', (String title){}, (String title){}),
                        CheckBox(getLearnTopic(snapshot.data).contains(4),'Business English', (String title){}, (String title){}),
                        CheckBox(getLearnTopic(snapshot.data).contains(5),'Conversational English',(String title){}, (String title){}),
                        
                        CheckBox(getTestPreparations(snapshot.data).contains(1), 'STATERS',(String title){}, (String title){}),
                        CheckBox(getTestPreparations(snapshot.data).contains(2), 'MOVERS',(String title){}, (String title){}),
                        CheckBox(getTestPreparations(snapshot.data).contains(3), 'FLYERS',(String title){}, (String title){}),
                        CheckBox(getTestPreparations(snapshot.data).contains(4), 'KET',(String title){}, (String title){}),
                        CheckBox(getTestPreparations(snapshot.data).contains(5), 'PET',(String title){}, (String title){}),
                        CheckBox(getTestPreparations(snapshot.data).contains(6), 'IELTS',(String title){}, (String title){}),
                        CheckBox(getTestPreparations(snapshot.data).contains(7), 'TOEFL',(String title){}, (String title){}),
                        CheckBox(getTestPreparations(snapshot.data).contains(8), 'TOEIC',(String title){}, (String title){}), 
                      ]
                    )
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Button(setting.language == "English" ? 'Save' : 'Lưu', () { Navigator.pop(context);}),
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

