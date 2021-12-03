import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/authentication/social_signin.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();

}

class _SignUpState extends State<SignUp>{
  String name = "";
  String email= "";
  String password = "";
  String confirmPassword = "";

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
            TextInput(setting.language == "English" ? 'Full name' : "Họ tên", setting.language == "English" ? 'Full name' : "Họ tên", false, TextInputType.text, (String value) { setState(() {
              name = value;
            });}),
            TextInput('Email', 'example@email.com', false, TextInputType.emailAddress, (String value){ setState(() {
              email = value;
            });}),
            TextInput(setting.language == "English" ? 'Password' : "Mật khẩu", '******', true, TextInputType.text, (String value){ setState(() {
              password = value;
            });}),
            TextInput(setting.language == "English" ? 'Confirm password' : "Nhập lại mật khẩu", '******', true, TextInputType.text, (String value){setState(() {
              confirmPassword = value;
            });}),
            
            Button(setting.language == "English" ? "Sign up" : "Đăng ký", handleSignUp),
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