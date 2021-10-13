import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(this.content);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 50,
          margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              content,
              style: TextStyle(fontWeight: FontWeight.bold),
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