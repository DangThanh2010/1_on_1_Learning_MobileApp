import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class BookingDialog extends StatelessWidget{
  BookingDialog(this.start, this.end);

  final List<DateTime> start;
  final List<DateTime> end;

  List<Widget> generateListButton(List<DateTime> start, List<DateTime> end, BuildContext context){
    int temp = 0;
    List<Widget> result = [];
    for (var element in start) {
      result.add(
        Button(element.year.toString() + '-' + (element.month < 10 ? ('0' + element.month.toString()) : element.month.toString()) + '-' + (element.day < 10 ? ('0' + element.day.toString()) : element.day.toString())
        + '\n' + (element.hour < 10 ? ('0' + element.hour.toString()) : element.hour.toString()) + ':' + (element.minute < 10 ? ('0' + element.minute.toString()) : element.minute.toString())
        + '-' + (end[temp].hour < 10 ? ('0' + end[temp].hour.toString()) : end[temp].hour.toString()) + ':' + (end[temp].minute < 10 ? ('0' + end[temp].minute.toString()) : end[temp].minute.toString()),
        (){
          Navigator.pop(context);
        })
      );
      temp++;
    }
    return result;
  }

  Widget setupContent(List<DateTime> start, List<DateTime> end, context, Setting setting) {
    return 
      Container(
        color: setting.theme == "White" ? Colors.white : Colors.grey[800],
        height: 300, 
        width: 300, 
        child: ListView(
          children: generateListButton(start, end, context),)
    );
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return AlertDialog(  
      backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800], 
      title: Center(
        child: Text(setting.language == "English" ? 'Pick your schedule' : 'Hãy chọn lịch học bạn muốn',
                    style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)),
      ),
      content: setupContent(start, end, context, setting),
    );
  }
}