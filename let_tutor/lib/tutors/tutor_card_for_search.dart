import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/model/language_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/tutor_dto.dart';
import 'package:provider/provider.dart';

class TutorCardForSearch extends StatelessWidget {
  TutorCardForSearch(this.id);

  final int id;

  List<Widget> generateLanguageTags(List<LanguageDTO> listLanguage){
    List<Tag> tags = [];
    for(int j = 0; j < listLanguage.length; j++){
      if(id == listLanguage[j].idTutor){
        tags.add(Tag(listLanguage[j].language, true));
      }
    }
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    ListTutorDTO tutors = context.watch<ListTutorDTO>();
    List<LanguageDTO> languages = context.watch<List<LanguageDTO>>();
    TutorDTO? tutor = tutors.getTutor(id);
    
    return GestureDetector(
      onTap: () {},
      child: Card(
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
                      image: AssetImage(tutor!.avatar),
                    )
                  ),
                ),
                            
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(tutor.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                          Expanded(
                            child: 
                            Container (
                              margin: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('5.00', style: TextStyle(color: Colors.red),),
                                  Icon(Icons.star_rate, color: Colors.yellow,),    
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
                            children: generateLanguageTags(languages)
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
                tutor.introduction,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            )
          ],
        ),
      )
    );
  }
}