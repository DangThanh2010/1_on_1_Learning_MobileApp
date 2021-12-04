import 'package:flutter/material.dart';
import 'package:let_tutor/global_widget/tag.dart';
import 'package:let_tutor/model/language_dto.dart';
import 'package:let_tutor/model/list_comment_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/setting.dart';
import 'package:let_tutor/model/tutor_dto.dart';
import 'package:let_tutor/tutor_detail/tutor_detail.dart';
import 'package:provider/provider.dart';

class TutorCard extends StatelessWidget {
  TutorCard(this.id);

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
    ListCommentDTO comments = context.watch<ListCommentDTO>();
    TutorDTO? tutor = tutors.getTutor(id);
    int star = comments.getRateForTutor(id);
    Setting setting = context.watch<Setting>();

    return GestureDetector(
      onTap: () {Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SafeArea(child: TutorDetail(id))),
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
                      image: AssetImage(tutor!.avatar),
                    )
                  ),
                ),
                            
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tutor.name, style: TextStyle(fontWeight: FontWeight.bold, color: setting.theme == "White" ? Colors.black : Colors.white),),
                              Row(
                                children: List<Widget>.generate(star, (index) => const Icon(Icons.star_rate, color: Colors.yellow,))
                                          + List<Widget>.generate(5 - star, (index) => const Icon(Icons.star_rate, color: Colors.black,)) 
                              )
                            ],
                          ),

                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  tutor.isFavourite ? tutors.setNotFavourite(id) : tutors.setFavourite(id);
                                },
                                child: tutor.isFavourite ? const Icon(Icons.favorite, color: Colors.pink,) : const Icon(Icons.favorite_border, color: Colors.pink,)
                              )
                            )
                          )
                        ],
                                  ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(right: 10),
                        child: 
                        SingleChildScrollView(
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
                style: TextStyle(color: setting.theme == "White" ? Colors.black : Colors.white),
              ),
            )
          ],
        ),
      )
    );
  }
}