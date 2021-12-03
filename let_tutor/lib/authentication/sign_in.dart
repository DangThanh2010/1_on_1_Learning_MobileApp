import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/authentication/social_signin.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

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
  void handleSignIn(){
    if(email == "admin@email.com" && password == "admin"){
      setLoginStatus();
    }
    else{
      if(email == "" || password == ""){
        showSnackBar("Email and password cannot be empty.");
      }else if(!validateEmail(email)){
        showSnackBar("The email is not a valid email address.");
      }
      else{
        showSnackBar("Email or password incorrectly.");
      }
    }
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
            TextInput('Email','example@email.com', false, TextInputType.emailAddress, (String value){ setState(() {
              email = value;
            });} ),
            TextInput(setting.language == "English" ? 'Password' : "Mật khẩu", '******', true, TextInputType.text, (String value){ setState(() {
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
            Button(setting.language == "English" ? 'Sign in' : "Đăng nhập", handleSignIn),
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