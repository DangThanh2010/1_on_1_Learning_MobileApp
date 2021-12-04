import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/message_detail/message_detail.dart';
import 'package:let_tutor/model/comment_dto.dart';
import 'package:let_tutor/model/language_dto.dart';
import 'package:let_tutor/model/list_comment_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/setting.dart';
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
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),)
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

  String dateTimeToString(DateTime dateTime){
    return (dateTime.hour < 10 ? ('0' + dateTime.hour.toString()) : dateTime.hour.toString()) + ':' + (dateTime.minute < 10 ? ('0' + dateTime.minute.toString()) : dateTime.minute.toString()) + ':' + (dateTime.second < 10 ? ('0' + dateTime.second.toString()) : dateTime.second.toString()) + ', ' + (dateTime.day < 10 ? ('0' + dateTime.day.toString()) : dateTime.day.toString()) + '/' + (dateTime.month < 10 ? ('0' + dateTime.month.toString()) : dateTime.month.toString()) + '/' + dateTime.year.toString();
  }

  List<Widget> generateComments(List<CommentDTO> listComment){
    List<Widget> comments = [];
    for(int j = 0; j < listComment.length; j++){
      if(id == listComment[j].idTutor){
        comments.add(Comment(const AssetImage('images/avatar.jpg'), 'April Corpuz', listComment[j].star, listComment[j].comment, dateTimeToString(listComment[j].dateTime)));
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
    int star = comments.getRateForTutor(id);
    Setting setting = context.watch<Setting>();
    
    return Scaffold(
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Center(
                child: Text(
                  'Video',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)
                  )
              )
            ),

            Intro(AssetImage(tutor!.avatar), tutor.name, tutor.nation, star, tutor.isFavourite, () { tutor.isFavourite ? tutors.setNotFavourite(id) : tutors.setFavourite(id);}),

            Button(setting.language == "English" ? 'Booking' : 'Đặt lịch', () {
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
                   IconText(Icons.chat, setting.language == "English" ? 'Message' : "Nhắn tin", () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SafeArea(child: MessageDetail())),
                  );},),
                   IconText(Icons.report, setting.language == "English" ? 'Report' : "Báo cáo", () {
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
                tutor.introduction,
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
                  children: generateLanguageTags(languages)
                ),
              )
            ),
           
            titleName(setting.language == "English" ? 'Education' : 'Học vấn'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text(tutor.education, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
            ),

            titleName(setting.language == "English" ? 'Experience' : 'Kinh nghiệm'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text(tutor.experience, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
            ),

            titleName(setting.language == "English" ? 'Interests' : 'Sở thích'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text(tutor.interests, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
            ),

            titleName(setting.language == "English" ? 'Profession' : 'Nghề nghiệp'),
            Container(
              margin: const EdgeInsets.only( left: 20, right: 20),
              child: Text(tutor.profession, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white))
            ),

            titleName(setting.language == "English" ? 'Specialties' : 'Chuyên môn'),
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

            titleName(setting.language == "English" ? 'Rating and Comment (${comments.getLengthForTutor(tutor.id)})' : 'Đánh giá và bình luận (${comments.getLengthForTutor(tutor.id)})'),
          ] + generateComments(comments.list),
        ),
      )
    );
  }
}