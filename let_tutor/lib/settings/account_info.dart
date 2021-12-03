import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';


class AccountInfo extends StatelessWidget {
  AccountInfo(this.avatar, this.name, this.email);

  final ImageProvider avatar;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    
    return GestureDetector(
      onTap: () {Navigator.pushNamed(context, "/profile"); },
      child: Container(
        margin: const EdgeInsets.only(top:20, left: 20, right: 20, bottom: 10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
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
                            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: setting.theme == "White" ? Colors.black : Colors.white),),
                Text(email, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),   
              ],
            ),
          ]
        )
      )
    );
  }
}