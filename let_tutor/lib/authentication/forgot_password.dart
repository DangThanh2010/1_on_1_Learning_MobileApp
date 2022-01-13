import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget{
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>{
  String email= "";
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
  void handleForgotPassword(Setting setting) async{
    setState(() {
      isLoading = true;
    });

    if(email == ""){
      showSnackBar(setting.language == "English" ? "Email cannot be empty." : 'Email không được rỗng.');
    }else if(!validateEmail(email)){
      showSnackBar(setting.language == "English" ? "The email is not a valid email address." : 'Email không đúng định dạng.');
    }else {
      var res = await http.post(Uri.parse(APILINK + "user/forgotPassword"),
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode({ "email": email})
                      );
      if(res.statusCode == 200){
        showSnackBar(setting.language == "English" ? "Send email successfully. Please check email." : 'Hệ thống đã gửi email thành công. Vui lòng kiểm tra email.');
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
        title: Text(setting.language == "English" ? 'Forgot password' : "Quên mật khẩu", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 100,
              width: 100,
              child: Image.asset('images/logo.png')
            ),

            isLoading ? 
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Center(
                  child: CircularProgressIndicator()
                )
              )
               : Container(),
            Container(
              height: 180,
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
              child: Center(
                child: Text(
                  setting.language == "English" ? "Enter your email address and we'll send you a link to reset your password" : "Nhập địa chỉ email của bạn. Chúng tôi sẽ gửi cho bạn một đường link để đặt lại mật khẩu.",
                  style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
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
                      style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                      decoration: InputDecoration(
                       
                        hintText: setting.language == "English" ? 'Enter your email' : "Nhập địa chỉ email",
                        hintStyle: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
                      ),
                    )
                  ),
                ],
              ) 
            ),
            Button(setting.language == "English" ? 'Send' : "Gửi", () {handleForgotPassword(setting);}),
          ],
        ),
      )
    );
  }
}