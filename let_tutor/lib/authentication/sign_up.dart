import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/authentication/social_signin.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();

}

class _SignUpState extends State<SignUp>{
  String email= "";
  String password = "";
  String confirmPassword = "";
  bool isLoading = false;

  bool validateEmail(String email){
    for(int i = 0; i < email.length; i++){
      if(email[i] == '@'){
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
  void handleSignUp(Setting setting) async{
    setState(() {
      isLoading = true;
    });

    if(email == "" || password == "" || confirmPassword == ""){
      showSnackBar(setting.language == "English" ? "Informations cannot be empty." : 'Thông tin không được rỗng.');
    }else if(!validateEmail(email)){
      showSnackBar(setting.language == "English" ? "The email is not a valid email address." : 'Email không đúng định dạng.');
    }else if(password != confirmPassword){
      showSnackBar(setting.language == "English" ? "Confirm password incorrectly." : 'Nhập lại mật khẩu không đúng.');
    }else{
      var res = await http.post(Uri.parse(APILINK + "auth/register"),
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode({
                          "email": email,
                          "password": password,
                          "source": ""
                        })
                      );
      if(res.statusCode == 201){
        showSnackBar(setting.language == "English" ? "Register successfully. Please check email to verify your email address." : 'Đăng ký thành công. Vui lòng kiểm tra email để xác thực tài khoản.');
        Navigator.pop(context);
      }
      else{
        showSnackBar(setting.language == "English" ? "Error! Please try again." : 'Đã xảy ra lỗi! Vui lòng thử lại.');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: setting.theme == "White" ? Colors.black : Colors.white
        ),
        title: Text(setting.language == "English" ? 'Sign up' : "Đăng ký", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: [
            isLoading ? 
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Center(
                  child: CircularProgressIndicator()
                )
              )
               : Container(),
               
            TextInput('Email', 'example@email.com', false, TextInputType.emailAddress, (String value){ setState(() {
              email = value;
            });}),
            TextInput(setting.language == "English" ? 'Password' : "Mật khẩu", '******', true, TextInputType.text, (String value){ setState(() {
              password = value;
            });}),
            TextInput(setting.language == "English" ? 'Confirm password' : "Nhập lại mật khẩu", '******', true, TextInputType.text, (String value){setState(() {
              confirmPassword = value;
            });}),
            
            Button(setting.language == "English" ? "Sign up" : "Đăng ký", () {handleSignUp(setting);}),
            SocialSignin(),

            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                Text(setting.language == "English" ? "Already have an account? " : "Bạn đã có tài khoản? ", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),), 
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(setting.language == "English" ? "Sign in" : "Đăng nhập")
                )
              ]
            ),
          ],
        ),
      )
    );
  }
}