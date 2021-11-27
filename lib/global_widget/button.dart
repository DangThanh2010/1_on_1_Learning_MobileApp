import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(this.content, this.callBack);

  final String content;
  final VoidCallback callBack;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: ElevatedButton(
        onPressed: callBack,
        child: Text(
          content,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
        ),
      )
    );
  }
}