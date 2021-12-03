class BookingDTO{
  BookingDTO(this.id, this.idTutor, this.start, this.end, this.isCancel, this.isFeedbacked);

  final int id;
  final int idTutor;
  final DateTime start;
  final DateTime end;
  final bool isCancel;
  final bool isFeedbacked;
}