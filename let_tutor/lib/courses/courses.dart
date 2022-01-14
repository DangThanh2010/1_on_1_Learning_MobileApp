import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/courses/course_card.dart';
import 'package:let_tutor/model/list_course.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses>{
  String searchValue = "";
  int page = 1;

  Future<ListCourse> fetchListCourse () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.get(Uri.parse(APILINK + "course?page=$page&size=5" + (searchValue == "" ? "" : ("&q=" + searchValue))),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                });
    if(res.statusCode == 200){
      var list = ListCourse.fromJson(jsonDecode(res.body)['data']); 
      return list;  
    }else {
      return ListCourse();
    }
  }


  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return Scaffold(
      appBar: AppBar(
        title: Text(setting.language == "English" ? 'Courses' : "Khóa học", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: CupertinoSearchTextField(
                onSubmitted: (String value) {
                  setState(() {
                    searchValue = value;
                    page = 1;
                  });
                },
                onChanged: (String value){
                  if(value == ""){
                    setState(() {
                      searchValue = value;
                      page = 1;
                    });
                  }
                },
                backgroundColor: setting.theme == "White" ? Colors.grey[200] : Colors.grey,
                itemColor: setting.theme == "White" ? Colors.black : Colors.white,
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                placeholder: setting.language == "English" ? 'Search course' : "Tìm kiếm khóa học",
                placeholderStyle: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              )
            ),
  
            Expanded(
              child: FutureBuilder<ListCourse>(
                future: fetchListCourse(),
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
                      if(snapshot.data.rows == null){
                        return Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(setting.language == "English" ? 'Error.' : 'Đã xảy ra lỗi.',
                                        style: TextStyle(fontWeight: FontWeight.bold,
                                                        color: setting.theme == "White" ? Colors.black : Colors.white, ),)
                          )
                        );
                      }
                      if(snapshot.data.rows.length == 0){
                        return Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(setting.language == "English" ? 'No data.' : 'Không có dữ liệu.',
                                        style: TextStyle(fontWeight: FontWeight.bold,
                                                        color: setting.theme == "White" ? Colors.black : Colors.white, ),)
                          )
                        );
                      }
                      return ListView(
                        children: snapshot.data.rows.map<Widget>((e) => CourseCard(e)).toList()
                        + [Container(
                            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                            child: Row(
                              children: [
                                page > 1 ?
                                TextButton(
                                  onPressed: (){ setState(() {
                                    page = page - 1;
                                  });},
                                  child: Text(setting.language == "English" ? '< Pre-page' : '< Trang trước')
                                ) : Container(),
                                snapshot.data.count > page*5 ? 
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: (){ setState(() {
                                        page = page + 1;
                                      });},
                                      child: Text(setting.language == "English" ? 'Next page >' : 'Trang sau >')
                                    )
                                  )
                                ) : Container(),]
                            )
                          )]
                        );
                    }
                    return Container();
                  },
                )
            ),
          ]
        )
      )
    );
  }
}