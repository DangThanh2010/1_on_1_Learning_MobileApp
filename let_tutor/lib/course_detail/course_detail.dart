import 'package:flutter/material.dart';
import 'package:let_tutor/course_detail/topic.dart';
import 'package:let_tutor/model/course_dto.dart';
import 'package:let_tutor/model/topic_dto.dart';
import 'package:provider/provider.dart';

class CourseDetail extends StatelessWidget {
  CourseDetail(this.course);

  final CourseDTO course;

  Widget partName(String name){
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
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

    return Scaffold(
      body: Container(
        color: Colors.white,
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

            partName('About Course'),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text(
                course.about
              ) 
            ),

            partName('Overview'),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  Text('Why take this course?'), 
                ],
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text(course.overview1)
            ),

            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  Text('What will you be able to do?'), 
                ],
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text(course.overview2)
            ),

            partName('Experience Level'),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text(course.level) 
            ),

            partName('Course Length'),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Text('${course.length} Topics') 
            ),

            partName('List Topics'),

          ]
          + 
          generateListTopic(course.id, topics)
        ),
      )
    );
  }
}
