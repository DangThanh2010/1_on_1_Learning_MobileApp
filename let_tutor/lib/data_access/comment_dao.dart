import 'package:let_tutor/data_access/db.dart';
import 'package:let_tutor/model/comment_dto.dart';

class CommentDAO{
  DB database = DB.instance;
  
  Future insert(CommentDTO item) async{
    await database.insert("Comment", item.toMap());
  }

  Future<List<CommentDTO>> getCommentList() async{
    List<Map<String, dynamic>>? result = await database.getTable("Comment");

    return List.generate(result!.length, (index) => CommentDTO(result[index]["id"], result[index]["idTutor"], result[index]["star"], result[index]["comment"], DateTime.parse(result[index]["dateTime"])));
  }

  Future delete(int id) async{
    await database.delete("Comment", "id = ?", [id]);
  }

  Future update(int id, CommentDTO item) async{
    await database.update("Commetn", item.toMap(), "id = ?", [id]);
  }
}