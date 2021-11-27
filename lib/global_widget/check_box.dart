
import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  CheckBox(this.title, this.callBack);

  final String title;
  final Function(String) callBack;
  @override
  State<CheckBox> createState() => CheckBoxState(title, callBack);
}


class CheckBoxState extends State<CheckBox> {
  CheckBoxState(this.title, this.callBack);

  final String title;
  final Function(String) callBack;
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {

    return CheckboxListTile(
      value: isChecked,
      title: Text(title),
      onChanged: (bool? value) {
        if(value == true)
        {
          callBack(title);
        }
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}
