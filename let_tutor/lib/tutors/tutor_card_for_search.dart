import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/tag.dart';


class TutorCardForSearch extends StatelessWidget {
  TutorCardForSearch(this.avatar, this.name, this.tags, this.introduce);

  final ImageProvider avatar;
  final String name;
  final List<Tag> tags;
  final String introduce;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.only(top:10, left: 20, right: 20, bottom: 10),
        elevation: 4,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: avatar,
                    )
                  ),
                ),
                            
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                          Expanded(
                            child: 
                            Container (
                              margin: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('5.00', style: TextStyle(color: Colors.red),),
                                  Icon(Icons.star_rate, color: Colors.yellow,),    
                                ],
                              )
                            )
                          ),
                        ],
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(right: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: tags
                          )
                        )
                      )
                    ]
                  )
                )
              ],
            ),

            Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              height: 68,
              child: Text(
                introduce,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            )
          ],
        ),
      )
    );
  }
}