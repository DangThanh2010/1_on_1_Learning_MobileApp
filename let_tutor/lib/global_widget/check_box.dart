
import 'package:flutter/material.dart';

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

    return CheckboxListTile(
      value: isChecked,
      title: Text(title),
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
    );
  }
}
