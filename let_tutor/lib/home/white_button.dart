import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  WhiteButton(this.content);

  final String content;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        content,
        style: TextStyle(
          color: Colors.blue,
        )
      ),
                            
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        primary: Colors.white  
      ),
    ); 
  }
}