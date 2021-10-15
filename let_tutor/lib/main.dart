import 'package:flutter/material.dart';
import 'package:let_tutor/authentication/forgot_password.dart';
import 'package:let_tutor/authentication/sign_in.dart';
import 'package:let_tutor/authentication/sign_up.dart';
import 'package:let_tutor/home/home.dart';

void main() {
  runApp(MaterialApp(
    title: "Let Tutor",
    home: SafeArea(
      child: Home(),),
  ));
}