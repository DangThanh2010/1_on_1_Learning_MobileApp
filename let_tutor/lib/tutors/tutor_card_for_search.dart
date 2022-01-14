import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/tutor.dart';
import 'package:let_tutor/tutor_detail/tutor_detail.dart';
import 'package:provider/provider.dart';

class TutorCardForSearch extends StatelessWidget {
  TutorCardForSearch(this.tutor);

  final Tutor tutor;

  List<Widget> generateLanguageTags(){
    List<Tag> tags = [];
    var listLanguage = tutor.languages!.split(',');
    for(int j = 0; j < listLanguage.length; j++){
      tags.add(Tag(listLanguage[j], true));
    }
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    
    return GestureDetector(
      onTap: () {Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SafeArea(child: TutorDetail(tutor.userId ?? "0"))),
      );},
      child: Card(
        color: setting.theme == "White" ? Colors.white : Colors.grey[800],
        margin: const EdgeInsets.only(top:10, left: 20, right: 20, bottom: 10),
        elevation: 4,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(tutor.avatar ?? ""),
                    )
                  ),
                ),
                            
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(tutor.name ?? "No name", style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),),
                          Expanded(
                            child: 
                            Container (
                              margin: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${(tutor.avgRating() * 100).floor() / 100}', style: TextStyle(color: Colors.red),),
                                  const Icon(Icons.star_rate, color: Colors.yellow,),    
                                ],
                              )
                            )
                          ),
                        ],
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(right: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: generateLanguageTags()
                          )
                        )
                      )
                    ]
                  )
                )
              ],
            ),

            Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              height: 68,
              child: Text(
                tutor.bio ?? " ",
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white)
              ),
            )
          ],
        ),
      )
    );
  }
}