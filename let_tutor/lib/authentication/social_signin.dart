import 'package:flutter/material.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';

class SocialSignin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Text(
            setting.language == "English" ? 'Or continue with' : "Hoặc tiếp tục với",
            style: TextStyle(color: setting.theme == "White" ? Colors.grey : Colors.white),
          ),

          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInButton.mini(
                  buttonType: ButtonType.google,
                  onPressed: () {},
                ),
                SignInButton.mini(
                  buttonType: ButtonType.facebook,
                  onPressed: () {},
                ),
                SignInButton.mini(
                  buttonType: ButtonType.apple,
                  onPressed: () {},
                ),
              ],
            )
          ),
        ]
      )
    );
  }
}