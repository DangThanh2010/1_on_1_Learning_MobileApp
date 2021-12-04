import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/model/list_comment_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/specialty_dto.dart';
import 'package:let_tutor/model/tutor_dto.dart';

import 'package:let_tutor/tutors/tutor_card_for_search.dart';
import 'package:provider/provider.dart';


class Tutors extends StatefulWidget {
  @override
  _TutorsState createState() => _TutorsState();

}

class _TutorsState extends State<Tutors>{
  String searchValue = "";
  String tagValue = "All";
  final List<String> tags = ["All", 'English for Kids', 'Conversational English', 'Business English', 'IELTS', 'TOEIC', 'TOEFL', 'PET', 'KET']; 

  bool checkSpecialty(int id, String specialty, List<SpecialtyDTO> specialties){
    if(specialty == "All"){
      return true;
    }
    for(int i = 0; i < specialties.length; i++){
      if(specialties[i].idTutor == id && specialties[i].specialty == specialty){
        return true;
      }
    }
    return false;
  }

  int sortTutor(TutorDTO a, TutorDTO b, ListCommentDTO listComment){
    if (a.isFavourite == true && b.isFavourite == false){
      return -1;
    }
    if (a.isFavourite == false && b.isFavourite == true){
      return 1;
    }
    return (listComment.getRateForTutor(b.id) - listComment.getRateForTutor(a.id)); 
  }

  @override
  Widget build(BuildContext context) {
    ListTutorDTO tutors = context.watch<ListTutorDTO>();
    List<SpecialtyDTO> specialties = context.watch<List<SpecialtyDTO>>();
    ListCommentDTO comments = context.watch<ListCommentDTO>();
    Setting setting = context.watch<Setting>();

    tutors.list.sort((a, b) => sortTutor(a, b, comments));
    
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
                  setState(() {
                  searchValue = value;
                  });
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
              child: ListView(
                children: searchValue == "" ? tutors.list.where((e) => checkSpecialty(e.id, tagValue, specialties)).toList().map((item) => TutorCardForSearch(item.id)).toList() 
                          : tutors.list.where((e) => (e.name.toLowerCase().contains(searchValue.toLowerCase()) && checkSpecialty(e.id, tagValue, specialties))).toList().map((item) => TutorCardForSearch(item.id)).toList()  
              )
            )
          ],
        ),
      )
    );
  }
}