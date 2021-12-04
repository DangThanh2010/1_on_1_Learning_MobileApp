import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/button.dart';
import 'package:let_tutor/global_widget/selected_input.dart';
import 'package:let_tutor/global_widget/text_input.dart';
import 'package:let_tutor/model/comment_dto.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/list_comment_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class GiveFeedbackDialog extends StatefulWidget{
  GiveFeedbackDialog(this.name, this.idTutor, this.idBooking);

  final String name;
  final int idTutor;
  final int idBooking;

  @override
  _GiveFeedbackDialogState createState() => _GiveFeedbackDialogState(name, idTutor, idBooking);

}

class _GiveFeedbackDialogState extends State<GiveFeedbackDialog>{
  _GiveFeedbackDialogState(this.name, this.idTutor, this.idBooking);

  final String name;
  final int idTutor;
  final int idBooking;
  
  int star = 1;
  String feedback = "";

  Widget setupContent(context, Setting setting, ListCommentDTO comments, ListBookingDTO bookings, int idTutor, int idBooking, int _star, String _feedback) {
    return 
      Container(
        color: setting.theme == "White" ? Colors.white : Colors.grey[800],
        height: 300,
        width: 300, 
        child: ListView(
          children: [
            SelectedInput(setting.language == "English" ? 'How many stars do you give for tutor?' : 'Bạn muốn đánh giá bao nhiêu sao cho gia sư?', 
                        setting.language == "English" ? 'Number of star' : 'Số sao', (String value) { 
                          setState(() {
                            star = int.parse(value);
                          });
                        }, ['1', '2', '3', '4', '5']),
            TextInput(setting.language == "English" ? 'Feedback' : 'Đánh giá',
                     setting.language == "English" ? 'Feedback' : 'Đánh giá', false, TextInputType.text, (String value){
                       setState(() {
                         feedback = value;
                       });
                     }),

            Button(setting.language == "English" ? 'Give Feedback' : 'Gửi đánh giá', () {
              comments.addComment(CommentDTO(comments.getNextId(), idTutor, _star, _feedback, DateTime.now()));
              bookings.setFeedback(idBooking);
              Navigator.pop(context);
            })
          ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    ListCommentDTO comments = context.watch<ListCommentDTO>();
    ListBookingDTO bookings = context.watch<ListBookingDTO>();
    Setting setting = context.watch<Setting>();

    return AlertDialog(
      backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
      title: Center(
        child: Text(setting.language == "English" ? 'Give feedback for ' + name : "Gửi đánh giá về " + name,
                    style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)),
      ),
      content: setupContent(context, setting, comments, bookings, idTutor, idBooking, star, feedback),
    );
  }
}