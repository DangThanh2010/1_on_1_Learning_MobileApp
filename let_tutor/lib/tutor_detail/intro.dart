import 'package:flutter/material.dart';


class Intro extends StatelessWidget {
  Intro(this.avatar, this.name, this.nation);

  final ImageProvider avatar;
  final String name;
  final String nation;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:10, left: 20, right: 20),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: avatar,
              )
            ),
          ),
                          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              Text('Teacher'),
              Text(nation, style: TextStyle(fontWeight: FontWeight.bold),),   
            ],
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.star_rate, color: Colors.yellow,),
                    Icon(Icons.star_rate, color: Colors.yellow,),
                    Icon(Icons.star_rate, color: Colors.yellow,),
                    Icon(Icons.star_rate, color: Colors.yellow,),
                    Icon(Icons.star_rate, color: Colors.yellow,),
                  ],
                ),
                Icon(Icons.favorite_border, color: Colors.pink,),
              ],
            )
          ),
        ]
      )
    );
  }
}