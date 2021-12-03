import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class SelectedInput extends StatefulWidget {
  SelectedInput(this.label, this.hint, this.callBack, this.selections);

  final String label;
  final String hint;
  final void Function(String) callBack;
  final List<String> selections;

  @override
  _SelectedInputState createState() => _SelectedInputState(label, hint, callBack, selections);
}

class _SelectedInputState extends State<SelectedInput> {
  String currentValue = "";

  _SelectedInputState(this.label, this.hint, this.callBack, this.selections);

  final String label;
  final String hint;
  final void Function(String) callBack;
  final List<String> selections;

  @override
  void initState() {
    super.initState();
    currentValue = selections[0];
  }

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
          Container(
            padding: const EdgeInsets.only( right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(20)
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        hint: Text(hint, style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),
                        value: currentValue,
                        onChanged: (value) {
                          setState(() {
                            currentValue = value.toString();
                          });
                          callBack(value.toString());
                        },

                        items: selections.map((selection) {
                          return DropdownMenuItem(
                            value: selection,
                            child: Text(selection, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600])));
                        }).toList(),
                      ),
                    ),
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}