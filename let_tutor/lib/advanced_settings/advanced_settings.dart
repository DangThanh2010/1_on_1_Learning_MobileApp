import 'package:flutter/material.dart';

class AdvancedSettings extends StatefulWidget {
  AdvancedSettings(this.currentLanguage);

  final String currentLanguage;
  @override
  _AdvancedSettingsState createState() => _AdvancedSettingsState(currentLanguage);
}

class _AdvancedSettingsState extends State<AdvancedSettings>{
  _AdvancedSettingsState(this.currentLanguage);

  final String currentLanguage;

  String language = '';

  @override
  void initState() {
    super.initState();
    language = currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black
        ),
        title: const Text('Advanced Settings', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Language', style: TextStyle(fontWeight: FontWeight.bold),),
                  DropdownButtonFormField<String>(
                    value: language,
                    iconSize: 0,

                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                    ),

                    onChanged: (String? newValue) {
                      setState(() {
                        language = newValue.toString();
                      });
                    },
                    items: ['Vietnamese', 'English'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 25,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: value == 'Vietnamese' ? AssetImage('images/Vietnam.jpg') : AssetImage('images/UK.png'),
                                )
                              ),
                            ),
                            Text(value),
                          ]
                        )
                      );
                    }).toList(),
                  ),
                ]
              )
            )
          ],
        )
      ) 
    );
  }
}