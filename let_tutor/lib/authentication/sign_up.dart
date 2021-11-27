import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/authentication/social_signin.dart';
import 'package:let_tutor/global_widget/text_input.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();

}

class _SignUpState extends State<SignUp>{
  String name = "";
  String email= "";
  String password = "";
  String confirmPassword = "";

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
  void handleSignUp(){
    if(email == "" || password == "" || name == "" || confirmPassword == ""){
      showSnackBar("Informations cannot be empty.");
    }else if(!validateEmail(email)){
      showSnackBar("The email is not a valid email address.");
    }else if(password != confirmPassword){
      showSnackBar("Confirm password incorrectly.");
    }else{
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
        title: const Text('Sign up', style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.white,
        elevation: 0.0,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            TextInput('Full name', 'Name', false, TextInputType.text, (String value) { setState(() {
              name = value;
            });}),
            TextInput('Email', 'example@email.com', false, TextInputType.emailAddress, (String value){ setState(() {
              email = value;
            });}),
            TextInput('Password', '******', true, TextInputType.text, (String value){ setState(() {
              password = value;
            });}),
            TextInput('Confirm password', '******', true, TextInputType.text, (String value){setState(() {
              confirmPassword = value;
            });}),
            
            Button('Sign up', handleSignUp),
            SocialSignin(),

            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '), 
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
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