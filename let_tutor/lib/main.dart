import 'package:flutter/material.dart';
import 'package:let_tutor/authentication/forgot_password.dart';
import 'package:let_tutor/authentication/sign_in.dart';
import 'package:let_tutor/authentication/sign_up.dart';
import 'package:let_tutor/become_a_tutor/become_a_tutor.dart';
import 'package:let_tutor/home/home.dart';
import 'package:let_tutor/profile/profile.dart';
import 'package:let_tutor/tutor_detail/tutor_detail.dart';
import 'package:let_tutor/tutors/tutors.dart';

void main() {
  runApp(MaterialApp(
    title: "Let Tutor",
    home: SafeArea(
      child: BecomeATutor(),),
  ));
}