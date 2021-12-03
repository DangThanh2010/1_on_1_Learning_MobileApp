import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class DateInput extends StatefulWidget{
  DateInput(this.label, this.hint, this.isPass, this.callBack);

  final String label;
  final String hint;
  final bool isPass;
  final void Function(String) callBack;
  @override
  _DateInputState createState() => _DateInputState(label, hint, isPass, callBack);
}

class _DateInputState extends State<DateInput> {
  _DateInputState(this.label, this.hint, this.isPass, this.callBack);

  final String label;
  final String hint;
  final bool isPass;
  final void Function(String) callBack;

  TextEditingController controller = TextEditingController(); 

  
  @override
  void initState() {
    controller.text = "";
    super.initState();
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
          SizedBox(
            height: 50,
            child: TextField(
              controller: controller,
              readOnly: true,
              obscureText: isPass,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(20)
                ),
                hintText: hint,
                hintStyle: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              ),

              onTap: () async {
                DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900), 
                  lastDate: DateTime.now(),
                );

                if(dateTime != null )
                {
                    String value = dateTime.year.toString() + '-' + dateTime.month.toString() + '-' + dateTime.day.toString();
                    setState(() {
                         controller.text = value;
                    });
                    callBack(value);
                }
              },
            )
          )
        ],
      )
    );
  }
}