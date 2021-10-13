import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/authentication/button.dart';

class ForgotPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.navigate_before, color: Colors.black,),
        title: const Text('Forgot password', style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.white ,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 100,
              width: 100,
              child: Image.asset('images/logo.png')
            ),
            Container(
              height: 180,
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
              child: const Center(
                child: Text(
                  "Enter your email address and we'll send you a link to reset your password",
                  textAlign: TextAlign.center,
                ),
              )
            ), 
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 50, left: 30, right: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.mail, color: Colors.blue)
                    )
                  ),

                  Expanded(
                    flex: 8,
                    child: TextField(
                      obscureText: false,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                      ),
                    )
                  ),
                ],
              ) 
            ),
            Button('Send'),
          ],
        ),
      )
    );
  }
}