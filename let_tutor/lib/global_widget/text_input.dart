import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class TextInput extends StatelessWidget {
  TextInput(this.label, this.hint, this.isPass, this.type, this.callBack);

  final String label;
  final String hint;
  final bool isPass;
  final TextInputType type;
  final void Function(String) callBack;

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 

        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),
            )
          ),
          SizedBox(
            child: TextField(
              keyboardType: type,
              onSubmitted: (value) => callBack(value),
              onChanged: (value) => callBack(value),
              obscureText: isPass,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: hint,
                hintStyle: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              ),
              maxLines: isPass ? 1 : null,
            )
          )
        ],
      )
    );
  }
}