import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class CheckBox extends StatefulWidget {
  CheckBox(this.title, this.callBack, this.callBack2);

  final String title;
  final Function(String) callBack;
  final Function(String) callBack2;
  @override
  State<CheckBox> createState() => CheckBoxState(title, callBack, callBack2);
}

class CheckBoxState extends State<CheckBox> {
  CheckBoxState(this.title, this.callBack, this.callBack2);

  final String title;
  final Function(String) callBack;
  final Function(String) callBack2;
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.grey,
        unselectedWidgetColor: Colors.grey
      ), 
      child: CheckboxListTile(
        value: isChecked,
        title: Text(title, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white,)),
        onChanged: (bool? value) {
          if(value == true){
            callBack(title);
          } else {
            callBack2(title);
          }
          setState(() {
            isChecked = value;
          });
        },
      )
    );
  }
}
