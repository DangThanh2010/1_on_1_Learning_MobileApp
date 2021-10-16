
import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  CheckBox(this.title);

  final String title;
  @override
  State<CheckBox> createState() => CheckBoxState(title);
}


class CheckBoxState extends State<CheckBox> {
  CheckBoxState(this.title);

  final String title;
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {

    return CheckboxListTile(
      value: isChecked,
      title: Text(title),
      onChanged: (bool? value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}
