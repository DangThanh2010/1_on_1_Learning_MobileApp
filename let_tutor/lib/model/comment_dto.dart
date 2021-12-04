class CommentDTO{
  CommentDTO(this.id, this.idTutor, this.star, this.comment, this.dateTime);

  final int id;
  final int idTutor;
  final int star;
  final String comment;
  final DateTime dateTime;
}