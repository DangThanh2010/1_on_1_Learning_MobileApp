import 'package:flutter/material.dart';
import 'package:let_tutor/course_detail/course_detail.dart';
import 'package:let_tutor/model/course.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  CourseCard(this.course);

  final Course course;

  final List<String> level = ["Any Level", "Beginner", "Upper-Beginner", "Pre-Intermediate", "Intermediate", "Upper-Intermediate",
                                "Pre-advanced", "Advanced", "Very advanced"];

  dynamic renderImage () {
    try {
      var res = NetworkImage(course.imageUrl ?? "");
      return res;
    }
    catch (e) {
      return AssetImage("images/course_picture.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return GestureDetector(
      onTap: () {
        /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SafeArea(child: CourseDetail(course))),
      );*/},
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
                  image: renderImage()
                )
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                course.name ?? "",
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                maxLines: null,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                course.description ?? "",
                style: TextStyle(color: setting.theme == "White" ? Colors.grey : Colors.white),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                setting.language == "English" ?  level[int.parse(course.level ?? "0")] + ' - ' + '${course.topics!.length} Lessons' :  level[int.parse(course.level ?? "0")] + ' - ' + '${course.topics!.length} bài',
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              ),
            ),
          ],
        )
      )
    );
  }
}