import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/tag.dart';


class TutorCard extends StatelessWidget {
  TutorCard(this.avatar, this.name, this.tags, this.introduce);

  final ImageProvider avatar;
  final String name;
  final List<Tag> tags;
  final String introduce;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                Icon(Icons.star_rate, color: Colors.yellow,),
                                Icon(Icons.star_rate, color: Colors.yellow,),
                                Icon(Icons.star_rate, color: Colors.yellow,),
                                Icon(Icons.star_rate, color: Colors.yellow,),
                                Icon(Icons.star_rate, color: Colors.yellow,),     
                              ],
                            )
                          ],
                        ),

                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child:  Icon(Icons.favorite_border, color: Colors.pink,)
                            )
                          )
                        )
                      ],
                                ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(right: 10),
                      child: 
                      SingleChildScrollView(
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
    );
  }
}