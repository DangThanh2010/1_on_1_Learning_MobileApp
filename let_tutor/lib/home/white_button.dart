import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  WhiteButton(this.content, this.callBack);

  final String content;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callBack,
      child: Text(
        content,
        style: const TextStyle(
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