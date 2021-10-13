import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  InputBox(this.label, this.hint, this.isPass);

  final String label;
  final String hint;
  final bool isPass;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 

        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ),
          Container(
            height: 50,
            child: TextField(
              obscureText: isPass,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(60)
                ),
                hintText: hint,
              ),
            )
          )
        ],
      )
    );
  }
}