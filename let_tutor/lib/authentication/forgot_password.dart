import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';

class ForgotPassword extends StatefulWidget{
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>{
  String email= "";

  bool validateEmail(String Email){
    for(int i = 0; i < Email.length; i++){
      if(Email[i] == '@'){
        return true;
      }
    }
    return false;
  }
  void showSnackBar(String content){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),),
        backgroundColor: Colors.white,
      ),
    );
  }
  void handleForgotPassword(){
    if(email == ""){
      showSnackBar("Email cannot be empty.");
    }else if(!validateEmail(email)){
      showSnackBar("The email is not a valid email address.");
    }else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black
        ),
        title: const Text('Forgot password', style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.white,
        elevation: 0.0,),
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
                      child: const Icon(Icons.mail, color: Colors.blue)
                    )
                  ),

                  Expanded(
                    flex: 8,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        email = value;
                      }),
                      onSubmitted: (value) => setState(() {
                        email = value;
                      }),
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
            Button('Send', handleForgotPassword),
          ],
        ),
      )
    );
  }
}