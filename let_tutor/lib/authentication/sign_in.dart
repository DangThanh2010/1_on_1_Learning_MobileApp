import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:let_tutor/config.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/authentication/social_signin.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/user_tokens.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  SignIn(this.setLoginStatus);

  final VoidCallback setLoginStatus;
  @override
  _SignInState createState() => _SignInState(setLoginStatus);

}
class _SignInState extends State<SignIn>{
  _SignInState(this.setLoginStatus);

  final VoidCallback setLoginStatus;

  String email = "";
  String password = "";
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
  void handleSignIn(Setting setting) async {
    setState(() {
      isLoading = true;
    });
    if(email == "" || password == ""){
      showSnackBar(setting.language == "English" ? "Email and password cannot be empty." : 'Email và mật khẩu không được rỗng.');
    }else if(!validateEmail(email)){
      showSnackBar(setting.language == "English" ? "The email is not a valid email address." : 'Email không đúng định dạng.');
    }
    else{
      var res = await http.post(Uri.parse(APILINK + "auth/login"),
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode({
                          "email": email,
                          "password": password
                        })
                      );
      if(res.statusCode == 200){
        var userTokens = UserTokens.fromJson(jsonDecode(res.body));
        final prefs = await SharedPreferences.getInstance();
        
        prefs.setString('accessToken', jsonEncode(userTokens.tokens!.access!.toJson()));
        setLoginStatus();
      }
      else{
        showSnackBar(setting.language == "English" ? "Email or password incorrectly." : 'Email hoặc mật khẩu không đúng.');
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
        title: Text(setting.language == "English" ? 'Sign in' : "Đăng nhập", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),), 
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: [
            SizedBox(
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
            TextInput('Email','example@email.com', false, TextInputType.emailAddress, (String value){ setState(() {
              email = value;
            });} ),
            TextInput(setting.language == "English" ? 'Password' : "Mật khẩu", "******", true, TextInputType.text, (String value){ setState(() {
              password = value;
            });} ),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 30),
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/forgot_password");
                },
                child: Text(setting.language == "English" ? "Forgot Password?" : "Quên mật khẩu?"),
              )
            ),
            Button(setting.language == "English" ? 'Sign in' : "Đăng nhập", () { handleSignIn(setting);}),
            SocialSignin(),

            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                Text(setting.language == "English" ? "Don't have account? " : "Bạn chưa có tài khoản? ", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign_up");
                  },
                  child: Text(setting.language == "English" ? "Sign up" : "Đăng ký"),
                )
              ]
            ),
          ],
        ),
      )
    );
  }
}