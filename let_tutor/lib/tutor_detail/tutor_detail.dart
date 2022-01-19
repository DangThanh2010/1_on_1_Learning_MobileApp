import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:let_tutor/model/tutor_detail_info.dart';
import 'package:let_tutor/tutor_detail/booking_dialog.dart';
import 'package:let_tutor/tutor_detail/comment.dart';
import 'package:let_tutor/tutor_detail/icon_text.dart';
import 'package:let_tutor/tutor_detail/intro.dart';
import 'package:let_tutor/tutor_detail/report_dialog.dart';
import 'package:let_tutor/tutor_detail/video.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class TutorDetail extends StatefulWidget {
  TutorDetail(this.id);
  
  final String id;

  @override
  State<StatefulWidget> createState() => _TutorDetailState(id);
  
}

class _TutorDetailState extends State<TutorDetail>{
  _TutorDetailState(this.id);
  
  final String id;

  bool isLoading = false;

  Future<TutorDetailInfo> fetchTutor () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.get(Uri.parse(APILINK + "tutor/" + id),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                });
    if(res.statusCode == 200){
      var tutor = TutorDetailInfo.fromJson(jsonDecode(res.body));  
      return tutor;
    }else {
      return TutorDetailInfo();
    }
  }

  void setFavoriteTutor () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    await http.post(Uri.parse(APILINK + "user/manageFavoriteTutor"),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
      },
      body: jsonEncode({
        "tutorId": id
    }));

    setState(() {
      isLoading = !isLoading;
    });
    
  }

  Widget titleName(String title){
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),)
    );
  } 

  List<Widget> generateTags(data){
    List<Tag> tags = [];
    var list = data.split(',');
    for(int j = 0; j < list.length; j++){
      tags.add(Tag(list[j], true));
    }
    return tags;
  }

  List<Widget> generateComments(listComment){
    List<Widget> comments = [];
    for(int j = 0; j < listComment.length; j++){
        comments.add(Comment(NetworkImage(listComment[j].firstInfo.avatar), listComment[j].firstInfo.name, listComment[j].rating, listComment[j].content, listComment[j].createdAt));
    }
    return comments;
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
      body: FutureBuilder<TutorDetailInfo>(
        future: isLoading ?  fetchTutor() : fetchTutor(),
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
            if(snapshot.data.userId == null){
              return Container(
                alignment: Alignment.center,
                child: Center(
                  child: Text(setting.language == "English" ? 'Error.' : 'Đã xảy ra lỗi.',
                      style: TextStyle(fontWeight: FontWeight.bold,
                                        color: setting.theme == "White" ? Colors.black : Colors.white, ),)
                )
              );
            }
            return Container(
              color: setting.theme == "White" ? Colors.white : Colors.black,
              child: ListView(
                children: [
                  SizedBox(
                    height: 200,
                    child: Center(
                      child: Video(snapshot.data.video)
                    )
                  ),

                  Intro(NetworkImage(snapshot.data.User.avatar ?? ""), snapshot.data.User.name, snapshot.data.User.country, snapshot.data.avgRating.ceil(), snapshot.data.isFavorite, () { 
                    setFavoriteTutor();
                  }),

                  Button(setting.language == "English" ? 'Booking' : 'Đặt lịch', () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return BookingDialog(id, showSnackBar);
                      }
                    );
                  }),

                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconText(Icons.report, setting.language == "English" ? 'Report' : "Báo cáo", () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ReportDialog(snapshot.data.User.name); 
                            }
                          );
                        },)
                      ],
                    ) 
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Text(
                      snapshot.data.bio,
                      style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)
                    ) 
                  ),

                  titleName(setting.language == "English" ? 'Languages' : 'Ngôn ngữ'),
                  Container(
                    margin: const EdgeInsets.only( left: 20, right: 20),
                    child:  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: generateTags(snapshot.data.languages)
                      ),
                    )
                  ),
                
                  titleName(setting.language == "English" ? 'Education' : 'Học vấn'),
                  Container(
                    margin: const EdgeInsets.only( left: 20, right: 20),
                    child: Text(snapshot.data.education, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
                  ),

                  titleName(setting.language == "English" ? 'Experience' : 'Kinh nghiệm'),
                  Container(
                    margin: const EdgeInsets.only( left: 20, right: 20),
                    child: Text(snapshot.data.experience, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
                  ),

                  titleName(setting.language == "English" ? 'Interests' : 'Sở thích'),
                  Container(
                    margin: const EdgeInsets.only( left: 20, right: 20),
                    child: Text(snapshot.data.interests, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
                  ),

                  titleName(setting.language == "English" ? 'Profession' : 'Nghề nghiệp'),
                  Container(
                    margin: const EdgeInsets.only( left: 20, right: 20),
                    child: Text(snapshot.data.profession, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
                  ),

                  titleName(setting.language == "English" ? 'Specialties' : 'Chuyên môn'),
                  Container(
                    margin: const EdgeInsets.only( left: 20, right: 20),
                    child:  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: generateTags(snapshot.data.specialties)
                      ),
                    )
                  ),

                  titleName(setting.language == "English" ? 'Rating and Comment (${snapshot.data.User.feedbacks.length})' : 'Đánh giá và bình luận (${snapshot.data.User.feedbacks.length})'),
                ] + generateComments(snapshot.data.User.feedbacks),
              ),
            );
          }
          return Container();
        },
      )
    );
  }
}