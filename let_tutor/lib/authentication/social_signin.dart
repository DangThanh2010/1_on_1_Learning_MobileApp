import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class SocialSignin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          const Text(
            'Or continue with',
            style: TextStyle(color: Colors.grey),
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
    )
    ;
  }
}