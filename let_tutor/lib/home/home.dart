import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/home/tutor_card.dart';
import 'package:let_tutor/home/white_button.dart';
import 'package:let_tutor/model/booking_info.dart';
import 'package:let_tutor/model/list_booking.dart';
import 'package:let_tutor/model/list_tutor.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:let_tutor/model/tutor.dart';
import 'package:let_tutor/model/user.dart';
import 'package:let_tutor/video_conference/video_conference.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home(this.setSelectedIndex);

  final void Function(int) setSelectedIndex;

  @override
  State<StatefulWidget> createState() => _HomeState(setSelectedIndex);

}
class _HomeState extends State<Home>{
  _HomeState(this.setSelectedIndex);

  final void Function(int) setSelectedIndex;

  bool isLoading = false;

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

  Future<ListBooking> fetchUpcoming () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    
    int timestamp = DateTime.now().millisecondsSinceEpoch - (1000 * 60 * 36);
    var res = await http.get(Uri.parse(APILINK + "booking/list/student?page=1&perPage=20&dateTimeGte=" + timestamp.toString()+ "&orderBy=meeting&sortBy=asc"),
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

  Future<int> fetchTotalHour () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.get(Uri.parse(APILINK + "call/total"),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                });
    if(res.statusCode == 200){
      var minutes = jsonDecode(res.body)['total']; 
      
      return minutes;  
    }else {
      return 0;
    }
  }

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

  String timeToLearnToString(int minutes, Setting setting){
    
    int minute = minutes % 60;
    int hour = minutes ~/ 60;

    String result = (hour < 10 ? ('0' + hour.toString()) : hour.toString()) + (setting.language == "English" ? ' hours ' : ' giờ ') + (minute < 10 ? ('0' + minute.toString()) : minute.toString()) + (setting.language == "English" ? ' minutes ' : ' phút ');

    return result;
  }

  String dateOfUpcomingToString(BookingInfo booking){
    DateTime start = DateTime.fromMicrosecondsSinceEpoch(booking.scheduleDetailInfo!.startPeriodTimestamp! * 1000, isUtc: false);
    
    return (start.hour < 10 ? ('0' + start.hour.toString()) : start.hour.toString()) + ':' + (start.minute < 10 ? ('0' + start.minute.toString()) : start.minute.toString()) + ':' + (start.second < 10 ? ('0' + start.second.toString()) : start.second.toString()) + ', ' + (start.day < 10 ? ('0' + start.day.toString()) : start.day.toString()) + '/' + (start.month < 10 ? ('0' + start.month.toString()) : start.month.toString()) + '/' + start.year.toString();
  }
  
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
          FutureBuilder<User>(
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
                return (
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data.avatar == "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png" ? "https://res.cloudinary.com/dangthanh/image/upload/v1641804706/AvatarEtutor/user_ryrffo.png" : snapshot.data.avatar),
                        )
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                  )
                );
              }
              return Container();
            }
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
                      child: FutureBuilder<int>(
                        future: fetchTotalHour(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return (
                              Text(
                                setting.language == "English" ? 'Total lesson time is ${timeToLearnToString(snapshot.data, setting)}' : 'Tổng thời gian đã học ${timeToLearnToString(snapshot.data, setting)}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            );
                          }
                          return Container();
                        }
                      ),
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

                    FutureBuilder<ListBooking>(
                      future: fetchUpcoming(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if(snapshot.data.rows == null){
                            return Container();
                          }
                          if(snapshot.data.rows.length == 0){
                            return(
                              Container(
                                margin: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    setting.language == "English" ? 'No upcoming lesson' : 'Không có buổi học sắp diễn ra',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    )
                                  )
                                )
                            );
                          }
                          return (
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: 
                                [Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    dateOfUpcomingToString(snapshot.data.rows[0]),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    )
                                  )
                                ), 
                                WhiteButton(setting.language == "English" ? 'Enter lesson room' : 'Vào lớp', (){ 
                                  String link = snapshot.data.rows[0].studentMeetingLink!;
                                  String token = link.split('=')[1];
                                  String b64 = token.split('.')[1];

                                  List<int> res = base64.decode(base64.normalize(b64));

                                  Map<String,dynamic> info = jsonDecode(utf8.decode(res));

                                  DateTime start = DateTime.fromMicrosecondsSinceEpoch(snapshot.data.rows[0].scheduleDetailInfo!.startPeriodTimestamp! * 1000, isUtc: false);
                                  
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SafeArea(child: VideoConference(info['room'], token, info['context']['user']['name'] ?? "", info['context']['user']['email'], start ))),
                                ); 
                                })
                              ] 
                            )
                          );     
                        }
                        return Container();
                      }
                    ),
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
              future: isLoading ? fetchListTutor() : fetchListTutor(),
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
                    children: snapshot.data.tutors.rows.map<Widget>((e) => TutorCard(e, snapshot.data, (){
                      setState(() {
                        isLoading = !isLoading;
                      });
                    })).toList()
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