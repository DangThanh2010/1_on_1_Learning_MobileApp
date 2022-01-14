import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';
import 'package:country_list_pick/country_list_pick.dart';

class CountryListPickWidget extends StatefulWidget {
  CountryListPickWidget(this.value, this.label, this.callBack);

  final String value;
  final String label;
  final void Function(String) callBack;

  @override
  _CountryListPickWidgetState createState() => _CountryListPickWidgetState(value, label, callBack);
}

class _CountryListPickWidgetState extends State<CountryListPickWidget> {
  String currentValue = "";

  _CountryListPickWidgetState(this.value, this.label, this.callBack);

  final String value;
  final String label;
  final void Function(String) callBack;

  @override
  void initState() {
    super.initState();
    currentValue = value;
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
                  child: CountryListPick(
                    theme: CountryTheme(
                      isShowFlag: true,
                      isShowTitle: true,
                      isShowCode: true,
                      isDownIcon: true,
                      showEnglishName: true,
                      labelColor: Colors.blueAccent,
                    ),
                    initialSelection: currentValue,
            
                    onChanged: (CountryCode? code) {
                      setState(() {
                        currentValue = code!.code!;
                      });
                      callBack(code!.code ?? "0");
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}