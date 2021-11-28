import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/specialty_dto.dart';

import 'package:let_tutor/tutors/tutor_card_for_search.dart';
import 'package:provider/provider.dart';


class Tutors extends StatefulWidget {
  @override
  _TutorsState createState() => _TutorsState();

}

class _TutorsState extends State<Tutors>{
  String searchValue = "";
  String tagValue = "All";
  final List<String> tags = ["All", 'English for Kids', 'Conversational English', 'IELTS']; 

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

  @override
  Widget build(BuildContext context) {
    ListTutorDTO tutors = context.watch<ListTutorDTO>();
    List<SpecialtyDTO> specialties = context.watch<List<SpecialtyDTO>>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutors', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: CupertinoSearchTextField(
                placeholder: 'Search Tutors',
                onSubmitted: (value){
                  setState(() {
                  searchValue = value;
                  });
                },
                onChanged: (value){
                  setState(() {
                  searchValue = value;
                  });
                }
              )
            ),
            
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: TextButton(
                onPressed: () {Navigator.pushNamed(context, "/become_a_tutor"); }, 
                child: const Text('Become a tutor >')
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
                children: searchValue == "" ? tutors.list.where((e) => checkSpecialty(e.id, tagValue, specialties)).toList().map((item) => TutorCardForSearch(item.id)).toList() : tutors.list.where((e) => (e.name.toLowerCase().contains(searchValue.toLowerCase()) && checkSpecialty(e.id, tagValue, specialties))).toList().map((item) => TutorCardForSearch(item.id)).toList()  
              )
            )
          ],
        ),
      )
    );
  }
}