import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:let_tutor/model/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;


class AccountInfo extends StatelessWidget {

  Future<User> fetchUser () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.get(Uri.parse(APILINK + "user/info"),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                });
    if(res.statusCode == 200){
      var user = User.fromJson(jsonDecode(res.body)['user']); 
      return user;
    }else {
      return User();
    }
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    
    return FutureBuilder<User>(
      future: fetchUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.hasData) {
          if(snapshot.data.id == null){
            return Container(
              alignment: Alignment.center,
              child: Center(
                child: Text(setting.language == "English" ? 'Error.' : 'Đã xảy ra lỗi.',
                            style: TextStyle(fontWeight: FontWeight.bold,
                                            color: setting.theme == "White" ? Colors.black : Colors.white, ),)
              )
            );
          }
          return (GestureDetector(
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
                        image: NetworkImage(snapshot.data.avatar == "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png" ? "https://res.cloudinary.com/dangthanh/image/upload/v1641804706/AvatarEtutor/user_ryrffo.png" : snapshot.data.avatar),
                      )
                    ),
                  ),
                            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data.name ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: setting.theme == "White" ? Colors.black : Colors.white),),
                      Text(snapshot.data.email ?? "", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),   
                    ],
                  ),
                ]
              )
            )
          ));
        }
        return Container();
      }
    );
  }
}