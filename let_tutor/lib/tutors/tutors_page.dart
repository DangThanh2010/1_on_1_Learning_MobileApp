import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/model/list_tutor.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/token.dart';
import 'package:let_tutor/model/tutor.dart';
import 'package:let_tutor/model/tutors.dart';
import 'package:let_tutor/tutors/tutor_card_for_search.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class TutorsPage extends StatefulWidget {
  @override
  _TutorsPageState createState() => _TutorsPageState();

}

class _TutorsPageState extends State<TutorsPage>{
  String searchValue = "";
  String tagValue = "All";
  int page = 1;
  final List<String> tags = ["All", 'english-for Kids', 'conversational-english', 'business-english', 'ielts', 'toeic', 'toefl', 'pet', 'ket']; 

  bool checkSpecialty(Tutor tutor){
    if(tagValue == "All"){
      return true;
    }else {
      var listSpec = tutor.specialties!.split(',');
      return listSpec.contains(tagValue);
    }
  }

  Future<ListTutor> fetchListTutor () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.get(Uri.parse(APILINK + "tutor/more?perPage=5&page=" + page.toString()),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                });
    if(res.statusCode == 200){
      var list = ListTutor.fromJson(jsonDecode(res.body)); 
      for(var i = 0; i < list.tutors!.rows!.length; i++){
        if(!checkSpecialty(list.tutors!.rows![i])){
          list.tutors!.rows!.removeAt(i);
        }
      }
      list.tutors!.rows!.sort((a, b) => sortTutor(a, b, list));
      return list;  
    }else {
      return ListTutor();
    }
  }

  Future<ListTutor> fetchListSearchTutor () async{
    final prefs = await SharedPreferences.getInstance();
    Token access = Token.fromJson(jsonDecode(prefs.getString('accessToken') ?? '{"token": "0", "expires":"0"}'));

    var res = await http.post(Uri.parse(APILINK + "tutor/search"),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' + (access.token ?? '0'),
                },
                body: json.encode({ "studentRequest": searchValue}));
    if(res.statusCode == 200){
      var list = Tutors.fromJson(jsonDecode(res.body));
      
      for(var i = 0; i < list.rows!.length; i++){
        if(!checkSpecialty(list.rows![i])){
          list.rows!.removeAt(i);
        }
      }
      var listTutor = ListTutor(tutors: list, favoriteTutor: null);
      listTutor.tutors!.rows!.sort((a, b) => sortTutor(a, b, listTutor));
      return listTutor;  
    }else {
      return ListTutor();
    }
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

    return Scaffold(
      appBar: AppBar(
        title: Text(setting.language == "English" ? 'Tutors' : "Gia sư", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: CupertinoSearchTextField(
                onSubmitted: (value){
                  setState(() {
                    searchValue = value;
                  });
                },
                onChanged: (value){
                  if(value == ""){
                    setState(() {
                      searchValue = value;
                    });
                  }
                },
                backgroundColor: setting.theme == "White" ? Colors.grey[200] : Colors.grey,
                itemColor: setting.theme == "White" ? Colors.black : Colors.white,
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                placeholder: setting.language == "English" ? 'Search Tutors' : "Tìm kiếm gia sư",
                placeholderStyle: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              )
            ),
            
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: TextButton(
                onPressed: () {Navigator.pushNamed(context, "/become_a_tutor"); }, 
                child: Text(setting.language == "English" ? 'Become a tutor >' : "Trở thành gia sư >")
              )
            ),
            
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: tags.map((e) => GestureDetector(
                    onTap: (){ setState(() {
                      tagValue = e;
                    });},
                    child: Tag(e, e == tagValue ? true : false)
                  )
                ).toList()),
              )
            ),
            Expanded(
              child: FutureBuilder<ListTutor>(
                  future: searchValue == ""  ? fetchListTutor() : fetchListSearchTutor(),
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
                      return ListView(
                        children: snapshot.data.tutors.rows.map<Widget>((e) => TutorCardForSearch(e)).toList() + 
                        [searchValue != "" ? Container() :
                          Container(
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
                                snapshot.data.tutors.count > page*5 ? 
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
                          ),]
                      );
                    }
                    return Container();
                  },
                )
              ),
          ],
        ),
      )
    );
  }
}