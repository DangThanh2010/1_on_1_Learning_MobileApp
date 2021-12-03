import 'package:flutter/material.dart';
import 'package:let_tutor/feedback_list/feedback_list_card.dart';
import 'package:let_tutor/model/feedback_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:provider/provider.dart';

class FeedbackList extends StatelessWidget {

  int getStar(List<FeedbackDTO> feedbacks){
    double result = 0;
    for(int i = 0; i < feedbacks.length; i++){
      result += feedbacks[i].star;
    }
    return (result / feedbacks.length).round();
  }

  @override
  Widget build(BuildContext context) {
    List<FeedbackDTO> feedbacks = context.watch<List<FeedbackDTO>>();
    Setting setting = context.watch<Setting>();
    
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: setting.theme == "White" ? Colors.black : Colors.white
        ),
        title: Text(setting.language == "English" ? 'Feedback List' : "Danh sách đánh giá", style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),),  
        backgroundColor: setting.theme == "White" ? Colors.white : Colors.grey[800],
        elevation: 0.0,),
      body: Container(
        color: setting.theme == "White" ? Colors.white : Colors.black,
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${getStar(feedbacks)}', style: const TextStyle(fontSize: 30, color: Colors.red),),
                  const Icon(Icons.star_rate, color: Colors.yellow, size: 30,)
                ],
              )
            ),
          ] + feedbacks.map((e) => FeedbackListCard(e)).toList(),
        ),
      )
    );
  }
}