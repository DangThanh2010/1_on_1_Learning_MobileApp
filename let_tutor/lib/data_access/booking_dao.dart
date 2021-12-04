import 'package:let_tutor/data_access/db.dart';
import 'package:let_tutor/model/booking_dto.dart';


class BookingDAO{
  DB database = DB.instance;
  
  Future insert(BookingDTO item) async{
    await database.insert("Booking", item.toMap());
  }

  Future<List<BookingDTO>> getBookingList() async{
    List<Map<String, dynamic>>? result = await database.getTable("Booking");

    return List.generate(result!.length, (index) => BookingDTO(result[index]["id"], result[index]["idTutor"], DateTime.parse(result[index]["start"]), DateTime.parse(result[index]["end"]), result[index]["isCancel"] == 1 ? true : false, result[index]["isFeedbacked"] == 1 ? true : false));
  }

  Future delete(int id) async{
    await database.delete("Booking", "id = ?", [id]);
  }

  Future update(int id, BookingDTO item) async{
    await database.update("Booking", item.toMap(), "id = ?", [id]);
  }
}