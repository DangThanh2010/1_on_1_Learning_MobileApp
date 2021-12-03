import 'package:flutter/material.dart';

class FeedbackDTO{
  FeedbackDTO(this.id, this.idSender, this.star, this.comment, this.dateTime);

  final int id;
  final int idSender;
  final int star;
  final String comment;
  final DateTime dateTime;
}