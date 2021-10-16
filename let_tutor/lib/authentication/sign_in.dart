import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/authentication/input_box.dart';
import 'package:let_tutor/authentication/social_signin.dart';


class SignIn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.navigate_before, color: Colors.black,),
        title: const Text('Sign in', style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/logo.png')
            ),
            InputBox('Email', 'example@email.com', false),
            InputBox('Password', '******', true),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 30),
              child: Row(
                mainAxisAlignment : MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?')
                  )
                ]
              )
            ),
            Button('Sign in'),
            SocialSignin(),

            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                const Text("Don't have account? "),
                    
                TextButton(
                  onPressed: () {},
                  child: const Text('Sign up')
                )
              ]
            ),
          ],
        ),
      )
    );
  }
}

