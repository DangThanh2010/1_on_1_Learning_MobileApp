import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(this.label, this.hint, this.isPass, this.type, this.callBack);

  final String label;
  final String hint;
  final bool isPass;
  final TextInputType type;
  final void Function(String) callBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 

        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ),
          SizedBox(
            child: TextField(
              keyboardType: type,
              onSubmitted: (value) => callBack(value),
              obscureText: isPass,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(20)
                ),
                hintText: hint,
              ),
              maxLines: null,
            )
          )
        ],
      )
    );
  }
}