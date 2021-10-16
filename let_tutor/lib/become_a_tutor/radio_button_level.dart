import 'package:flutter/material.dart';

enum Level { Beginner, Intermediate, Advanced }  
  
class RadioButtonLevel extends StatefulWidget {  
  
  @override  
  RadioButtonLevelState createState() => RadioButtonLevelState();  
}  
  
class RadioButtonLevelState extends State<RadioButtonLevel> {  
  Level? level = Level.Beginner;  
  
  @override
  Widget build(BuildContext context) {  
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 

        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text('I am best at teaching students who are')
          ),
          
          ListTile(  
            title: const Text('Beginner'),  
            leading: Radio(  
              value: Level.Beginner,  
              groupValue: level,  
              onChanged: (Level? value) {  
                setState(() {  
                  level = value;  
                });  
              },  
            ),  
          ),  
          ListTile(  
            title: const Text('Intermediate'),  
            leading: Radio(  
              value: Level.Intermediate,  
              groupValue: level,  
              onChanged: (Level? value) {  
                setState(() {  
                  level = value;  
                });  
              },  
            ),  
          ),  
          ListTile(  
            title: const Text('Advanced'),  
            leading: Radio(  
              value: Level.Advanced,  
              groupValue: level,  
              onChanged: (Level? value) {  
                setState(() {  
                  level = value;  
                });  
              },  
            ),  
          ),  
        ],
      )
    );  
  }  
}  