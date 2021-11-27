import 'package:flutter/material.dart';


class Tag extends StatelessWidget {
  Tag(this.content, this.isChosen);

  final String content;
  final bool isChosen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.all(5),
        child: Text(content, style: TextStyle(color: isChosen ? Colors.blue : Colors.black54)),
        decoration: BoxDecoration(
          color: isChosen ? Colors.blue[50] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10)),
        )
    );
  }
}