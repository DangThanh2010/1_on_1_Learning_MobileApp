class BookingDTO{
  BookingDTO(this.id, this.idTutor, this.start, this.end, this.isCancel, this.isFeedbacked);

  final int id;
  final int idTutor;
  final DateTime start;
  final DateTime end;
  final bool isCancel;
  final bool isFeedbacked;

  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "idTutor": idTutor,
      "start": dateTimeToString(start),
      "end": dateTimeToString(end),
      "isCancel": isCancel ? 1 : 0,
      "isFeedbacked": isFeedbacked ? 1 : 0,
      
    };
  }
}

String dateTimeToString(DateTime dateTime){
  String result = "";
  result += dateTime.year.toString() + '-' + (dateTime.month < 10 ? ("0" + dateTime.month.toString()) : dateTime.month.toString()) + '-' + (dateTime.day < 10 ? ("0" + dateTime.day.toString()) : dateTime.day.toString());
  result += " " + (dateTime.hour < 10 ? ("0" + dateTime.hour.toString()) : dateTime.hour.toString()) + ':' + (dateTime.minute < 10 ? ("0" + dateTime.minute.toString()) : dateTime.minute.toString()) + ":00";
  return result;
}