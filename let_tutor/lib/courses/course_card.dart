import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  CourseCard(this.picture, this.name, this.introduce, this.level, this.numLesson);

  final ImageProvider picture;
  final String name;
  final String introduce;
  final String level;
  final int numLesson;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {},
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
                  image: picture,
                )
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                name,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                maxLines: null,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                introduce,
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                level + ' - ' + '${numLesson} Lessons',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        )
      )
    );
  }
}