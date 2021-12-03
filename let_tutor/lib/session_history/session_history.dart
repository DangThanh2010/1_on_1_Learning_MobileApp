import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/model/booking_dto.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/tutor_dto.dart';
import 'package:let_tutor/session_history/session_history_card.dart';
import 'package:provider/provider.dart';

class SessionHistory extends StatefulWidget {
  @override
  _SessionHistoryState createState() => _SessionHistoryState();
}

class _SessionHistoryState extends State<SessionHistory>{

  String searchValue = "";

  List<BookingDTO> getListSession(ListBookingDTO bookings){
    List<BookingDTO> result = [];
    for(int i = 0; i < bookings.list.length; i++){
      if(bookings.list[i].end.compareTo(DateTime.now()) < 0 && bookings.list[i].isCancel == false){
        result.add(bookings.list[i]);
      }
    }
    return result;
  }

  List<BookingDTO> getListSessionForSearch(ListBookingDTO bookings, ListTutorDTO tutors, String search){
    List<BookingDTO> result = [];
    for(int i = 0; i < bookings.list.length; i++){
      TutorDTO? tutor = tutors.getTutor(bookings.list[i].idTutor);

      if(bookings.list[i].end.compareTo(DateTime.now()) < 0 && bookings.list[i].isCancel == false
        && tutor!.name.toLowerCase().contains(search.toLowerCase())){
        result.add(bookings.list[i]);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    ListBookingDTO bookings = context.watch<ListBookingDTO>();
    ListTutorDTO tutors = context.watch<ListTutorDTO>();
    Setting setting = context.watch<Setting>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: setting.theme == "White" ? Colors.black : Colors.white
        ),
        title: Text(setting.language == "English" ? 'Session History' : "Lịch sử học", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: CupertinoSearchTextField(
                onChanged: (String value) {
                  setState(() {
                    searchValue = value;
                  });
                },
                onSubmitted: (String value) {
                  setState(() {
                    searchValue = value;
                  });
                },
                backgroundColor: setting.theme == "White" ? Colors.grey[200] : Colors.grey,
                itemColor: setting.theme == "White" ? Colors.black : Colors.white,
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                placeholder: setting.language == "English" ? 'Search session history' : "Tìm kiếm lịch sử học",
                placeholderStyle: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              )
            ),
  
            Expanded(
              child: ListView(
                children: searchValue == "" ? getListSession(bookings).map((e) => SessionHistoryCard(e)).toList() : getListSessionForSearch(bookings, tutors, searchValue).map((e) => SessionHistoryCard(e)).toList()
              )
            ),
          ]
        ),
      )
    );
  }
}