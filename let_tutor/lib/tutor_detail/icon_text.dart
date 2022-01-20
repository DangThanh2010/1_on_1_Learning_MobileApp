import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  IconText(this.icon, this.text, this.callBack);

  final IconData icon;
  final String text;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child:  Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Icon(icon, color: Colors.blue,)
          ),

          Text(text, style: const TextStyle(color: Colors.blue),)
        ],
      )
    );
  }
}
    