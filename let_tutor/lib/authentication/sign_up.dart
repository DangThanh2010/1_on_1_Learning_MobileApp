import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/authentication/social_signin.dart';
import 'package:let_tutor/global_widget/text_input.dart';

class SignUp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up', style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            TextInput('Full name', 'Name', false, TextInputType.text, (String value) {}),
            TextInput('Email', 'example@email.com', false, TextInputType.emailAddress, (String value){}),
            TextInput('Password', '******', true, TextInputType.text, (String value){}),
            TextInput('Confirm password', '******', true, TextInputType.text, (String value){}),
            
            Button('Sign up', () {}),
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