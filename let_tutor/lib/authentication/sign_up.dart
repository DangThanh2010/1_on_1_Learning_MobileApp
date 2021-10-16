import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/authentication/input_box.dart';
import 'package:let_tutor/authentication/social_signin.dart';

class SignUp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.navigate_before, color: Colors.black,),
        title: const Text('Sign up', style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            InputBox('Full name', 'Name', false),
            InputBox('Email', 'example@email.com', false),
            InputBox('Password', '******', true),
            InputBox('Confirm password', '******', true),
            
            Button('Sign up'),
            SocialSignin(),

            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                    
                TextButton(
                  onPressed: () {},
                  child: const Text('Sign in')
                )
              ]
            ),
          ],
        ),
      )
    );
  }
}