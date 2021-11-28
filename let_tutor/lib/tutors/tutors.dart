import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/tutors/tutor_card_for_search.dart';
import 'package:provider/provider.dart';


class Tutors extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ListTutorDTO tutors = context.watch<ListTutorDTO>();
    
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
                onChanged: (String value) {},
                onSubmitted: (String value) {},
                placeholder: 'Search Tutors',
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
                child: Row(children: [
                  Tag('All', true),
                  Tag('English for Kids', false),
                  Tag('Business English', false),
                  Tag('Conversational English', false),
                  Tag('IELTS', false),
                ],),
              )
            ),
            Expanded(
              child: ListView(
                children: tutors.list.map((e) => TutorCardForSearch(e.id)).toList()  
              )
            )
          ],
        ),
      )
    );
  }
}