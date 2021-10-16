import 'package:flutter/material.dart';


class PartName extends StatelessWidget {
  PartName(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)  ,
      )
    );
  }
}