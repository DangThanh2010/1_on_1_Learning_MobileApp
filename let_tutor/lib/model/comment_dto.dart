class CommentDTO{
  CommentDTO(this.id, this.idTutor, this.star, this.comment, this.dateTime);

  final int id;
  final int idTutor;
  final int star;
  final String comment;
  final DateTime dateTime;

   Map<String, dynamic> toMap(){
    return{
      "id": id,
      "idTutor": idTutor,
      "star": star,
      "comment": comment,
      "dateTime": dateTimeToString(dateTime)
    };
  }
}

String dateTimeToString(DateTime dateTime){
  String result = "";
  result += dateTime.year.toString() + '-' + (dateTime.month < 10 ? ("0" + dateTime.month.toString()) : dateTime.month.toString()) + '-' + (dateTime.day < 10 ? ("0" + dateTime.day.toString()) : dateTime.day.toString());
  result += " " + (dateTime.hour < 10 ? ("0" + dateTime.hour.toString()) : dateTime.hour.toString()) + ':' + (dateTime.minute < 10 ? ("0" + dateTime.minute.toString()) : dateTime.minute.toString()) + ":00";
  return result;
}