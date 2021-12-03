import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/model/comment_dto.dart';
import 'package:let_tutor/model/language_dto.dart';
import 'package:let_tutor/model/list_comment_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/specialty_dto.dart';
import 'package:let_tutor/model/tutor_dto.dart';
import 'package:let_tutor/tutor_detail/booking_dialog.dart';
import 'package:let_tutor/tutor_detail/comment.dart';
import 'package:let_tutor/tutor_detail/icon_text.dart';
import 'package:let_tutor/tutor_detail/intro.dart';
import 'package:let_tutor/tutor_detail/report_dialog.dart';
import 'package:provider/provider.dart';

class TutorDetail extends StatelessWidget {
  TutorDetail(this.id);
  
  final int id;

  Widget titleName(String title){
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),)
    );
  } 

  List<Widget> generateLanguageTags(List<LanguageDTO> listLanguage){
    List<Tag> tags = [];
    for(int j = 0; j < listLanguage.length; j++){
      if(id == listLanguage[j].idTutor){
        tags.add(Tag(listLanguage[j].language, true));
      }
    }
    return tags;
  }

  List<Widget> generateSpecialtyTags(List<SpecialtyDTO> listSpecialty){
    List<Tag> tags = [];
    for(int j = 0; j < listSpecialty.length; j++){
      if(id == listSpecialty[j].idTutor){
        tags.add(Tag(listSpecialty[j].specialty, true));
      }
    }
    return tags;
  }

  List<Widget> generateComments(List<CommentDTO> listComment){
    List<Widget> comments = [];
    for(int j = 0; j < listComment.length; j++){
      if(id == listComment[j].idTutor){
        comments.add(Comment(AssetImage('images/avatar.jpg'), 'April Corpuz', listComment[j].comment, listComment[j].dateTime.toString()));
      }
    }
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    ListTutorDTO tutors = context.watch<ListTutorDTO>();
    ListCommentDTO comments = context.watch<ListCommentDTO>();
    List<LanguageDTO> languages = context.watch<List<LanguageDTO>>();
    List<SpecialtyDTO> specialties = context.watch<List<SpecialtyDTO>>();
    TutorDTO? tutor = tutors.getTutor(id);
    
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Center(
                child: Text(
                  'Video',
                  textAlign: TextAlign.center,
                  )
              )
            ),

            Intro(AssetImage(tutor!.avatar), tutor.name, tutor.nation, tutor.isFavourite, () { tutor.isFavourite ? tutors.setNotFavourite(id) : tutors.setFavourite(id);}),

            Button('Booking', () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BookingDialog([DateTime(2021, 10, 24, 22, 0, 0, 0, 0), DateTime(2021, 10, 24, 23, 0, 0, 0, 0), DateTime(2021, 10, 25, 7, 0, 0, 0, 0),  DateTime(2021, 10, 25, 23, 0, 0, 0, 0), DateTime(2021, 10, 26, 8, 0, 0, 0, 0),],
                      [DateTime(2021, 10, 24, 22, 25, 0, 0, 0), DateTime(2021, 10, 24, 23, 25, 0, 0, 0), DateTime(2021, 10, 25, 7, 25, 0, 0, 0), DateTime(2021, 10, 25, 23, 25, 0, 0, 0),  DateTime(2021, 10, 26, 8, 25, 0, 0, 0)]);
                }
              );
            }),

            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   IconText(Icons.chat, 'Message', () {},),
                   IconText(Icons.report, 'Report', () {
                     showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReportDialog(tutor.name); 
                      }
                    );
                  },)
                ],
              ) 
            ),

            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                tutor.introduction
              ) 
            ),

            titleName('Languages'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child:  SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: generateLanguageTags(languages)
                ),
              )
            ),
           
            titleName('Education'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text(tutor.education)
            ),

            titleName('Experience'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text(tutor.experience)
            ),

            titleName('Interests'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text(tutor.interests)
            ),

            titleName('Profession'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text(tutor.profession)
            ),

            titleName('Specialties'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child:  SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: generateSpecialtyTags(specialties)
                ),
              )
            ),

            titleName('Rating and Comment (${comments.getLengthForTutor(tutor.id)})'),
          ] + generateComments(comments.list),
        ),
      )
    );
  }
}