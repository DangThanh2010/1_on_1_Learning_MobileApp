import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/courses/course_card.dart';
import 'package:let_tutor/model/course_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses>{
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    List<CourseDTO> courses = context.watch<List<CourseDTO>>();
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
                onChanged: (String value) {
                  setState(() {
                  searchValue = value;
                  });
                },
                onSubmitted: (String value) {
                  setState(() {
                  searchValue = value;
                  });
                },
                backgroundColor: setting.theme == "White" ? Colors.grey[200] : Colors.grey,
                itemColor: setting.theme == "White" ? Colors.black : Colors.white,
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                placeholder: setting.language == "English" ? 'Search course' : "Tìm kiếm khóa học",
                placeholderStyle: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              )
            ),
  
            Expanded(
              child: ListView(
                children: searchValue == "" ? courses.map((e) => CourseCard(e)).toList() : courses.where((e) => (e.name.toLowerCase().contains(searchValue.toLowerCase()))).toList().map((item) => CourseCard(item)).toList()
              )
            ),
          ]
        ),
      )
    );
  }
}