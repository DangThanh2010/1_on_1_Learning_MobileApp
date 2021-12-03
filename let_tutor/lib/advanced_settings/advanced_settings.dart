import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class AdvancedSettings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: setting.theme == "White" ? Colors.black : Colors.white
        ),
        title: Text(setting.language == "English" ? 'Advanced Settings' : "Cài đặt nâng cao", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(setting.language == "English" ? 'Language' : 'Ngôn ngữ', style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),),
                  DropdownButtonFormField<String>(
                    value: setting.language,
                    iconSize: 0,

                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                    ),

                    onChanged: (String? newValue) {
                      setting.changeLanguage(newValue!);
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
                                  image: value == 'Vietnamese' ? const AssetImage('images/Vietnam.jpg') : const AssetImage('images/UK.png'),
                                )
                              ),
                            ),
                            Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),),
                          ]
                        )
                      );
                    }).toList(),
                  ),
                ]
              )
            ),

            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(setting.language == "English" ? 'Theme' : 'Chủ đề', style: TextStyle(fontWeight: FontWeight.bold,  color: setting.theme == "White" ? Colors.black : Colors.white),),
                  DropdownButtonFormField<String>(
                    value: setting.theme,
                    iconSize: 0,

                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                    ),

                    onChanged: (String? newValue) {
                      setting.changeTheme(newValue!);
                    },
                    items: ['White', 'Dark'].map((String value) {
                      return DropdownMenuItem<String>(
                        
                        value: value,
                        child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),),
                        
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