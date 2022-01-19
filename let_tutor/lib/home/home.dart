import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/home/tutor_card.dart';
import 'package:let_tutor/home/white_button.dart';
import 'package:let_tutor/model/list_tutor.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:let_tutor/model/tutor.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  Home(this.setSelectedIndex);

  final void Function(int) setSelectedIndex;

  Future<ListTutor> fetchListTutor () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.get(Uri.parse(APILINK + "tutor/more?perPage=9&page=1"),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                });
    if(res.statusCode == 200){
      var list = ListTutor.fromJson(jsonDecode(res.body));  
      list.tutors!.rows!.sort((a, b) => sortTutor(a, b, list));
      return list;  
    }else {
      return ListTutor();
    }
  }
  /*
  int getTimeToLearn(ListBookingDTO bookings){
    int result = 0;
    for(int i = 0; i < bookings.list.length; i++){
      if(bookings.list[i].end.compareTo(DateTime.now()) < 0 && bookings.list[i].isCancel == false){
        //result += bookings.list[i].end.difference(bookings.list[i].start).inSeconds;
      }
    }
    return result;
  }*/

  String timeToLearnToString(int seconds, Setting setting){
    int second = seconds % 60;
    int minute = (seconds ~/ 60) % 60;
    int hour = (seconds ~/ 60) ~/ 60;

    String result = (hour < 10 ? ('0' + hour.toString()) : hour.toString()) + (setting.language == "English" ? ' hours ' : ' giờ ') + (minute < 10 ? ('0' + minute.toString()) : minute.toString()) + (setting.language == "English" ? ' minutes ' : ' phút ') + (second < 10 ? ('0' + second.toString()) : second.toString()) + (setting.language == "English" ? ' seconds' : ' giây');

    return result;
  }

/*
  List<BookingDTO> getListUpcoming(ListBookingDTO bookings){
    List<BookingDTO> result = [];
    for(int i = 0; i < bookings.list.length; i++){
      if(DateTime.now().compareTo(bookings.list[i].end) < 0 && bookings.list[i].isCancel == false){
        result.add(bookings.list[i]);
      }
    }
    return result;
  }

  String dateOfUpcomingToString(BookingDTO booking){
    return (booking.start.hour < 10 ? ('0' + booking.start.hour.toString()) : booking.start.hour.toString()) + ':' + (booking.start.minute < 10 ? ('0' + booking.start.minute.toString()) : booking.start.minute.toString()) + ':' + (booking.start.second < 10 ? ('0' + booking.start.second.toString()) : booking.start.second.toString()) + ', ' + (booking.start.day < 10 ? ('0' + booking.start.day.toString()) : booking.start.day.toString()) + '/' + (booking.start.month < 10 ? ('0' + booking.start.month.toString()) : booking.start.month.toString()) + '/' + booking.start.year.toString();
  }
  */

  int sortTutor(Tutor a, Tutor b, ListTutor list){

    if (list.checkFavoriteTutor(a.userId) == true && list.checkFavoriteTutor(b.userId) == false){
      return -1;
    }
    if (list.checkFavoriteTutor(a.userId) == false && list.checkFavoriteTutor(b.userId) == true){
      return 1;
    }
    return ((b.avgRating() - a.avgRating()).isNegative ? -1 : 1); 
  }

  @override
  Widget build(BuildContext context) {
    
    Setting setting = context.watch<Setting>();

    return  Scaffold(
      appBar: AppBar(
        title: Text(setting.language == "English" ? 'Home' : "Trang chủ", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),), 
        actions: [
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/avatar.jpg'),
                )
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
          )
        ],
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: [
            Container(
              color: Colors.blue,
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: 
                      Text(
                        setting.language == "English" ? 'Total lesson time is ' : 'Tổng thời gian đã học ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ),

                    
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: 
                      Text(
                        setting.language == "English" ? 'Upcoming lesson' : 'Buổi học sắp diễn ra',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ),
                    /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getListUpcoming(bookings).isNotEmpty ?  [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text(
                            dateOfUpcomingToString(getListUpcoming(bookings)[0]),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            )
                          )
                        ), 
                        WhiteButton(setting.language == "English" ? 'Enter lesson room' : 'Vào lớp', (){ Navigator.pushNamed(context, "/video_conference");})
                      ] : [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text(
                            setting.language == "English" ? 'No upcoming lesson' : 'Không có buổi học sắp diễn ra',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            )
                          )
                        ), 
                      ],
                    ),
                    */
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: WhiteButton(setting.language == "English" ? 'Book more' : 'Đặt lịch', (){ setSelectedIndex(3); })
                    )
                  ]
                )
            ),

            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    setting.language == "English" ? 'Recommended Tutors' : 'Gia sư được đề xuất',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: setting.theme == "White" ? Colors.black : Colors.white,
                    )
                  ),

                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){ setSelectedIndex(3); },
                        child: Text(setting.language == "English" ? 'See all >' : 'Tất cả >')
                      )
                    )
                  ),
                ]
              )
            ),
            
            FutureBuilder<ListTutor>(
              future: fetchListTutor(),
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
                  if(snapshot.data.tutors == null){
                    return Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(setting.language == "English" ? 'Error.' : 'Đã xảy ra lỗi.',
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                                    color: setting.theme == "White" ? Colors.black : Colors.white, ),)
                      )
                    );
                  }
                  if(snapshot.data.tutors.rows.length == 0){
                    return Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(setting.language == "English" ? 'No data.' : 'Không có dữ liệu.',
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                                    color: setting.theme == "White" ? Colors.black : Colors.white, ),)
                      )
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data.tutors.rows.map<Widget>((e) => TutorCard(e, snapshot.data)).toList()
                  );
                }
                return Container();
              },
            )
          ],
        ),
      )
    );
  }
}