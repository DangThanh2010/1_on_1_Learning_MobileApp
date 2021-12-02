import 'package:flutter/material.dart';
import 'package:let_tutor/course_detail/course_detail.dart';
import 'package:let_tutor/model/course_dto.dart';

class CourseCard extends StatelessWidget {
  CourseCard(this.course);

  final CourseDTO course;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CourseDetail(course)),
      );},
      child: Card(
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
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                maxLines: null,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                course.about,
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                course.level + ' - ' + '${course.length} Lessons',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        )
      )
    );
  }
}