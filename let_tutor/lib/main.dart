import 'package:flutter/material.dart';
import 'package:let_tutor/authentication/sign_in.dart';

void main() {
  runApp(MaterialApp(
    title: "Let Tutor",
    home: SafeArea(
      child: Signin(),),
  ));
}