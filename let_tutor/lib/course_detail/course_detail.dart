import 'package:flutter/material.dart';
import 'package:let_tutor/course_detail/topic.dart';
import 'package:let_tutor/model/course_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/topic_dto.dart';
import 'package:provider/provider.dart';

class CourseDetail extends StatelessWidget {
  CourseDetail(this.course);

  final CourseDTO course;

  Widget partName(String name, Setting setting){
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),)
    );
  } 

  List<Widget> generateListTopic(int id, List<TopicDTO> topics){
    int temp = 1;
    List<Widget> result = [];
    for (var topic in topics) {
      if(topic.idCourse == id){
        result.add(Topic(temp, topic));
        temp++;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    List<TopicDTO> topics = context.watch<List<TopicDTO>>();
    Setting setting = context.watch<Setting>();

    return Scaffold(
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
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

            partName(setting.language == "English" ? 'About Course' : "Thông tin khóa học", setting),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text(
                course.about,
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
              child: Text(course.overview1, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
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
              child: Text(course.overview2, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
            ),

            partName(setting.language == "English" ? 'Experience Level' : "Mức độ kinh ngiệm", setting),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text(course.level, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)) 
            ),

            partName(setting.language == "English" ? 'Course Length' : "Độ dài khóa học", setting),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text(setting.language == "English" ? '${course.length} Topics' : '${course.length} chủ đề', style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)) 
            ),

            partName(setting.language == "English" ? 'List Topics' : "Danh sách chủ đề", setting),
          ]
          + 
          generateListTopic(course.id, topics)
        ),
      )
    );
  }
}
