import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/course_detail/topic.dart';
import 'package:let_tutor/model/course.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CourseDetail extends StatelessWidget {
  CourseDetail(this.id);

  final String id;

  final List<String> level = ["Any Level", "Beginner", "Upper-Beginner", "Pre-Intermediate", "Intermediate", "Upper-Intermediate",
                                "Pre-advanced", "Advanced", "Very advanced"];


  Future<Course> fetchCourse () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.get(Uri.parse(APILINK + "course/" + id),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                });
    if(res.statusCode == 200){
      var course = Course.fromJson(jsonDecode(res.body)['data']); 
      return course;  
    }else {
      return Course();
    }
  }

  dynamic renderImage (link) {
    try {
      var res = NetworkImage(link);
      return res;
    }
    catch (e) {
      return const AssetImage("images/course_picture.png");
    }
  }

  Widget partName(String name, Setting setting){
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),)
    );
  } 

  List<Widget> generateListTopic(topics){
    int temp = 1;
    List<Widget> result = [];
    for (var topic in topics) {
      result.add(Topic(temp, topic.name, topic.nameFile));
      temp++;
    }
    
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return Scaffold(
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: FutureBuilder<Course>(
          future: fetchCourse(),
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
              return ListView(
                children: [
                  Container(
                    height:180,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: renderImage(snapshot.data.imageUrl),
                      )
                    ),
                  ),

                  partName(setting.language == "English" ? 'About Course' : "Thông tin khóa học", setting),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Text(
                      snapshot.data.description,
                      style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)
                    ) 
                  ),

                  partName(setting.language == "English" ? 'Overview' : "Tổng quan", setting),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: setting.theme == "White" ? Colors.black : Colors.white,),
                        Text(setting.language == "English" ? 'Why take this course?' : "Tại sao nên tham gia khóa học này?", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)), 
                      ],
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Text(snapshot.data.reason, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: setting.theme == "White" ? Colors.black : Colors.white,),
                        Text(setting.language == "English" ? 'What will you be able to do?' : "Bạn sẽ nhận được gì?", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)), 
                      ],
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Text(snapshot.data.purpose, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
                  ),

                  partName(setting.language == "English" ? 'Experience Level' : "Mức độ kinh nghiệm", setting),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Text(level[int.parse(snapshot.data.level)], style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)) 
                  ),

                  partName(setting.language == "English" ? 'Course Length' : "Độ dài khóa học", setting),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Text(setting.language == "English" ? '${snapshot.data.topics.length} Topics' : '${snapshot.data.topics.length} chủ đề', style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)) 
                  ),

                  partName(setting.language == "English" ? 'List Topics' : "Danh sách chủ đề", setting),
                ]
                + 
                generateListTopic(snapshot.data.topics)
              );    
            }
            return Container();
          },
        )
      )
    );
  }
}
