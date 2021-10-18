import 'package:flutter/material.dart';

class SettingFeature extends StatelessWidget {
  SettingFeature(this.leading, this.title, this.trailing, this.callBack);

  final Icon leading;
  final String title;
  final Icon trailing;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 3,
          )
        ]
      ),
      child: ListTile(
        leading: leading,
        title: Text(title),
        trailing: trailing,
        onTap: callBack,
      )
    );
  }
}

