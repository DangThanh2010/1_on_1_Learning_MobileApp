import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class Intro extends StatelessWidget {

  Intro(this.avatar, this.name, this.nation, this.isFavourite, this.callBack);

  final ImageProvider avatar;
  final String name;
  final String nation;
  final bool isFavourite;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

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
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: setting.theme == "White" ? Colors.black : Colors.white,),),
              Text(setting.language == "English" ? 'Tutor' : "Gia sư", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white,),),
              Text(nation, style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white,),),   
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
                GestureDetector(
                  onTap: () {
                    callBack();
                  },
                  child: isFavourite ? const Icon(Icons.favorite, color: Colors.pink,) : const Icon(Icons.favorite_border, color: Colors.pink,),
                ),
              ],
            )
          ),
        ]
      )
    );
  }
}