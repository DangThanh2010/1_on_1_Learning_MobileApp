import 'package:let_tutor/data_access/db.dart';
import 'package:let_tutor/model/tutor_dto.dart';

class TutorDAO{
  DB database = DB.instance;
  
  Future insert(TutorDTO item) async {
    await database.insert("Tutor", item.toMap());
  }

  Future<List<TutorDTO>> getTutorList() async{
    List<Map<String, dynamic>>? result = await database.getTable("Tutor");

    return List.generate(result!.length, (index) => TutorDTO(result[index]["id"], result[index]["avatar"], result[index]["name"], result[index]["nation"], result[index]["isFavourite"] == 1 ? true : false, result[index]["introduction"], result[index]["education"], result[index]["experience"], result[index]["interests"], result[index]["profession"],));
  }

  Future delete(int id) async{
    await database.delete("Tutor", "id = ?", [id]);
  }

  Future update(int id, TutorDTO item) async{
    await database.update("Tutor", item.toMap(), "id = ?", [id]);
  }
}