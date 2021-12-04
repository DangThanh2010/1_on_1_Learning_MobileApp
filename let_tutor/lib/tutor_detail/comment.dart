import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class Comment extends StatelessWidget {
  Comment(this.avatar, this.name, this.comment, this.time);

  final ImageProvider avatar;
  final String name;
  final String comment;
  final String time;

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return Card(
      color: setting.theme == "White" ? Colors.white : Colors.grey[800],
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      elevation: 4,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 50,
                height: 50,
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
                        Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),),
                        Expanded(
                          child: 
                          Container (
                            margin: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.star_rate, color: Colors.yellow,),   
                                Icon(Icons.star_rate, color: Colors.yellow,),    
                                Icon(Icons.star_rate, color: Colors.yellow,),   
                                Icon(Icons.star_rate, color: Colors.yellow,),   
                                Icon(Icons.star_rate, color: Colors.yellow,),   
                              ],
                            )
                          )
                        ),
                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(comment, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
                    ),
                  ]
                )
              )
            ],
          ),

          Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: Text(time, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)),
          )
        ],
      ),
    );
  }
}