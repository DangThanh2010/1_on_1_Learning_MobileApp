import 'package:flutter/material.dart';
import 'package:let_tutor/home/tutor_card.dart';
import 'package:let_tutor/home/white_button.dart';
import 'package:let_tutor/model/booking_dto.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home(this.setSelectedIndex);

  final void Function(int) setSelectedIndex;

  int getTimeToLearn(ListBookingDTO bookings){
    int result = 0;
    for(int i = 0; i < bookings.list.length; i++){
      if(bookings.list[i].end.compareTo(DateTime.now()) < 0 && bookings.list[i].isCancel == false){
        result += bookings.list[i].end.difference(bookings.list[i].start).inSeconds;
      }
    }
    return result;
  }

  String timeToLearnToString(int seconds, Setting setting){
    int second = seconds % 60;
    int minute = (seconds ~/ 60) % 60;
    int hour = (seconds ~/ 60) ~/ 60;

    String result = (hour < 10 ? ('0' + hour.toString()) : hour.toString()) + (setting.language == "English" ? ' hours ' : ' giờ ') + (minute < 10 ? ('0' + minute.toString()) : minute.toString()) + (setting.language == "English" ? ' minutes ' : ' phút ') + (second < 10 ? ('0' + second.toString()) : second.toString()) + (setting.language == "English" ? ' seconds' : ' giây');

    return result;
  }

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

  @override
  Widget build(BuildContext context) {
    ListTutorDTO tutors = context.watch<ListTutorDTO>();
    ListBookingDTO bookings = context.watch<ListBookingDTO>();
    Setting setting = context.watch<Setting>();

    return Scaffold(
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
                        setting.language == "English" ? 'Total lesson time is ${timeToLearnToString(getTimeToLearn(bookings), setting)}' : 'Tổng thời gian đã học ${timeToLearnToString(getTimeToLearn(bookings), setting)}',
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
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tutors.list.map((e) => TutorCard(e.id)).toList()
            )
          ],
        ),
      )
    );
  }
}