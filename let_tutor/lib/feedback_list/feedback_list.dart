import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/feedback_list/feedback_list_card.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:let_tutor/model/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;

class FeedbackList extends StatelessWidget {

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
    
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: setting.theme == "White" ? Colors.black : Colors.white
        ),
        title: Text(setting.language == "English" ? 'Feedback List' : "Danh sách đánh giá", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: FutureBuilder<User>(
          future: fetchUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Center(
                  child: CircularProgressIndicator()
                )
              );
            }
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
              
              return(ListView(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${(snapshot.data.avgRating * 100).round() / 100}', style: const TextStyle(fontSize: 30, color: Colors.red),),
                        const Icon(Icons.star_rate, color: Colors.yellow, size: 30,)
                      ],
                    )
                  ),
                ] + snapshot.data.feedbacks.map<Widget>((e) => FeedbackListCard(e)).toList(),
              ));
            }
            return Container();
          }
        )
      )
    );
  }
}