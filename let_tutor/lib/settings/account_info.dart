import 'package:flutter/material.dart';


class AccountInfo extends StatelessWidget {
  AccountInfo(this.avatar, this.name, this.email);

  final ImageProvider avatar;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(email,),   
              ],
            ),
          ]
        )
      )
    );
  }
}