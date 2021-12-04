import 'package:flutter/material.dart';
import 'package:let_tutor/data_access/booking_dao.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/model/booking_dto.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/schedule_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class BookingDialog extends StatelessWidget{
  BookingDialog(this.schedules, this.callBack);

  final List<ScheduleDTO> schedules;
  final void Function(String) callBack;

  List<Widget> generateListButton(List<ScheduleDTO> schedules,  ListBookingDTO bookings, BuildContext context, Setting setting){
    List<Widget> result = [];
    for (var element in schedules) {
      result.add(
        Button(element.start.year.toString() + '-' + (element.start.month < 10 ? ('0' + element.start.month.toString()) : element.start.month.toString()) + '-' + (element.start.day < 10 ? ('0' + element.start.day.toString()) : element.start.day.toString())
        + '\n' + (element.start.hour < 10 ? ('0' + element.start.hour.toString()) : element.start.hour.toString()) + ':' + (element.start.minute < 10 ? ('0' + element.start.minute.toString()) : element.start.minute.toString())
        + '-' + (element.end.hour < 10 ? ('0' + element.end.hour.toString()) : element.end.hour.toString()) + ':' + (element.end.minute < 10 ? ('0' + element.end.minute.toString()) : element.end.minute.toString()),
        () async {
          int temp = 0;
          for(var i = 0; i < bookings.list.length; i++){
            if(bookings.list[i].idTutor == element.idTutor && bookings.list[i].start == element.start && bookings.list[i].end == element.end && bookings.list[i].isCancel == false){
              temp = 1;
            }

          }
          if(temp == 0){
            BookingDAO bookingDAO = BookingDAO();
            await bookingDAO.insert(BookingDTO(bookings.getNextId(), element.idTutor, element.start, element.end, false, false));
            bookings.addBooking(BookingDTO(bookings.getNextId(), element.idTutor, element.start, element.end, false, false));
            Navigator.pop(context);
            callBack(setting.language == "English" ? 'Book successfully' : "Đặt lịch thành công");
          }
          else {
            Navigator.pop(context);
            callBack(setting.language == "English" ? 'You have already booked this schedule' : "Bạn đã đặt lịch học này trước đó");
          }
        })
      );
    }
    return result;
  }

  Widget setupContent(List<ScheduleDTO> schedules, ListBookingDTO bookings, context, Setting setting) {
    return 
      Container(
        color: setting.theme == "White" ? Colors.white : Colors.grey[800],
        height: 300, 
        width: 300, 
        child: ListView(
          children: generateListButton(schedules, bookings, context, setting),)
    );
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    ListBookingDTO bookings = context.watch<ListBookingDTO>();

    return AlertDialog(  
      backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800], 
      title: Center(
        child: Text(setting.language == "English" ? 'Pick your schedule' : 'Hãy chọn lịch học bạn muốn',
                    style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)),
      ),
      content: setupContent(schedules, bookings, context, setting),
    );
  }
}