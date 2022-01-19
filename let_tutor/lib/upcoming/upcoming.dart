import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/model/list_booking.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:let_tutor/upcoming/upcoming_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class Upcoming extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpcomingState();
  
}

class _UpcomingState extends State<Upcoming>{

  int page = 1;
  bool isLoading = false;

  Future<ListBooking> fetchListUpcoming () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    
    int timestamp = DateTime.now().millisecondsSinceEpoch - (1000 * 60 * 36);

    var res = await http.get(Uri.parse(APILINK + "booking/list/student?page=" + page.toString() + "&perPage=20&dateTimeGte=" + timestamp.toString()+ "&orderBy=meeting&sortBy=asc"),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                });
    if(res.statusCode == 200){
      var listUpcoming = ListBooking.fromJson(jsonDecode(res.body)['data']); 
      
      return listUpcoming;  
    }else {
      return ListBooking();
    }
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    void showSnackBar(String content){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(content, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),),
          backgroundColor: Colors.white,
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(setting.language == "English" ? 'Upcoming' : "Sắp diễn ra", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: FutureBuilder<ListBooking>(
          future: isLoading ?  fetchListUpcoming() : fetchListUpcoming(),
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
              if(snapshot.data.rows == null){
                return Container(
                  alignment: Alignment.center,
                    child: Center(
                      child: Text(setting.language == "English" ? 'Error.' : 'Đã xảy ra lỗi.',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                                  color: setting.theme == "White" ? Colors.black : Colors.white, ),)
                    )
                  );
              }
              if(snapshot.data.rows.length == 0){
                return Container(
                  alignment: Alignment.center,
                    child: Center(
                      child: Text(setting.language == "English" ? 'No data.' : 'Không có dữ liệu.',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                                  color: setting.theme == "White" ? Colors.black : Colors.white, ),)
                      )
                  );
              }
              return ListView(
                children: snapshot.data.rows.map<Widget>((e) => UpcomingCard(e, (content) {
                  showSnackBar(content);
                  setState(() {
                    isLoading = !isLoading;
                  });
                })).toList() + 
                  [Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        children: [
                          page > 1 ?
                            TextButton(
                              onPressed: (){ setState(() {
                                page = page - 1;
                            });},
                              child: Text(setting.language == "English" ? '< Pre-page' : '< Trang trước')
                          ) : Container(),
                          snapshot.data.count > page*20 ? 
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: (){ setState(() {
                                    page = page + 1;
                                  });},
                                  child: Text(setting.language == "English" ? 'Next page >' : 'Trang sau >')
                                )
                              )
                            ): Container(),
                          ]
                        )
                      ),
                    ]
                  );
            }
            return Container();
          },
        )
      )
    );
  }
}