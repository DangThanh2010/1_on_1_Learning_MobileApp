import 'package:flutter/material.dart';
import 'package:let_tutor/advanced_settings/advanced_settings.dart';
import 'package:let_tutor/authentication/forgot_password.dart';
import 'package:let_tutor/authentication/sign_in.dart';
import 'package:let_tutor/authentication/sign_up.dart';
import 'package:let_tutor/become_a_tutor/become_a_tutor.dart';
import 'package:let_tutor/booking_history/booking_history.dart';
import 'package:let_tutor/course_detail/course_detail.dart';
import 'package:let_tutor/courses/courses.dart';
import 'package:let_tutor/feedback_list/feedback_list.dart';
import 'package:let_tutor/home/home.dart';
import 'package:let_tutor/message/message.dart';
import 'package:let_tutor/message_detail/message_detail.dart';
import 'package:let_tutor/profile/profile.dart';
import 'package:let_tutor/session_history/session_history.dart';
import 'package:let_tutor/settings/settings.dart';
import 'package:let_tutor/tutor_detail/tutor_detail.dart';
import 'package:let_tutor/tutors/tutors.dart';
import 'package:let_tutor/upcoming/upcoming.dart';
import 'package:let_tutor/video_conference/video_conference.dart';

void main() {
  runApp(MaterialApp(
    title: "Let Tutor",
    home: SafeArea(
      child: VideoCoference(),
    ),
  ));
}