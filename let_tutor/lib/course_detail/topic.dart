import 'package:flutter/material.dart';

class Topic extends StatelessWidget {
  Topic(this.number, this.name);

  final int number;
  final String name;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.purple[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('${number}', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),),
            ),

            Text(name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
          ],
        ),
      )
    );
  }
}