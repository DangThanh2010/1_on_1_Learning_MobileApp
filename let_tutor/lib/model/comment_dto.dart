class CommentDTO{
  CommentDTO(this.id, this.idTutor, this.comment, this.dateTime);

  final int id;
  final int idTutor;
  final String comment;
  final DateTime dateTime;
}