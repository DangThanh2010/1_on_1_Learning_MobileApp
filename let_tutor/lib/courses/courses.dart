import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/course_detail/course_detail.dart';
import 'package:let_tutor/courses/course_card.dart';
import 'package:let_tutor/model/course_dto.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
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
                placeholder: 'Search course',
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