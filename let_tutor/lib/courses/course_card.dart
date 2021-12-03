import 'package:flutter/material.dart';
import 'package:let_tutor/course_detail/course_detail.dart';
import 'package:let_tutor/model/course_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  CourseCard(this.course);

  final CourseDTO course;

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return GestureDetector(
      onTap: () {Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SafeArea(child: CourseDetail(course))),
      );},
      child: Card(
        color: setting.theme == "White" ? Colors.white : Colors.grey[800],
        margin: const EdgeInsets.only(top:10, left: 20, right: 20, bottom: 10),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height:180,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(course.picture),
                )
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                course.name,
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                maxLines: null,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                course.about,
                style: TextStyle(color: setting.theme == "White" ? Colors.grey : Colors.white),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                setting.language == "English" ?  course.level + ' - ' + '${course.length} Lessons' :  course.level + ' - ' + '${course.length} bài',
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              ),
            ),
          ],
        )
      )
    );
  }
}