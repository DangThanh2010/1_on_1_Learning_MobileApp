import 'package:flutter/material.dart';
import 'package:let_tutor/authentication/forgot_password.dart';
import 'package:let_tutor/authentication/sign_in.dart';
import 'package:let_tutor/authentication/sign_up.dart';
import 'package:let_tutor/become_a_tutor/become_a_tutor.dart';
import 'package:let_tutor/booking_history/booking_history.dart';
import 'package:let_tutor/home/home.dart';
import 'package:let_tutor/profile/profile.dart';
import 'package:let_tutor/settings/settings.dart';
import 'package:let_tutor/tutor_detail/tutor_detail.dart';
import 'package:let_tutor/tutors/tutors.dart';
import 'package:let_tutor/upcoming/upcoming.dart';

void main() {
  runApp(MaterialApp(
    title: "Let Tutor",
    home: SafeArea(
      child: BookingHistory(),),
  ));
}