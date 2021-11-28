import 'package:let_tutor/model/comment_dto.dart';
import 'package:let_tutor/model/language_dto.dart';
import 'package:let_tutor/model/list_comment_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/specialty_dto.dart';
import 'package:let_tutor/model/tutor_dto.dart';

ListTutorDTO listTutorDTO = ListTutorDTO([
  TutorDTO(1, 'images/avatar.jpg', 'April Corpuz', 'Vietnam', false, 'I was born in Chester, United Kingdom, but now live in Vietnam. I am a person of varied interests, I love baking, reading, photography and languages. I enjoy teaching English to all ages and levels as I believe it opens the door to global opportunities. I am a fun, talkative person who loves to find out about others cultures and experience.', 'IELTS 8.0 (Speaking: 8.0, Listening: 8.5, Reading: 8.5, Writing: 7.5)', '3 years', 'Teaching English, listening to music, shopping, eating', 'English teacher'),
  TutorDTO(2, 'images/avatar2.jpg', 'Keegan', 'Philippines', false, 'I was born in Chester, United Kingdom, but now live in Manila, Philippines. I am a person of varied interests, I love baking, reading, photography and languages. I enjoy teaching English to all ages and levels as I believe it opens the door to global opportunities. I am a fun, talkative person who loves to find out about others cultures and experience.', 'IELTS 7.0 (Speaking: 7.0, Listening: 7.5, Reading: 7.5, Writing: 6.5)', '2 years', 'Teaching English, listening to music, shopping, play game', 'English teacher'),
  TutorDTO(3, 'images/avatar3.jpg', 'Levi', 'Japan', false, 'I was born in Chester, United Kingdom, but now live in Japan. I am a person of varied interests, I love baking, reading, photography and languages. I enjoy teaching English to all ages and levels as I believe it opens the door to global opportunities. I am a fun, talkative person who loves to find out about others cultures and experience.', 'IELTS 7.0 (Speaking: 7.0, Listening: 7.5, Reading: 7.5, Writing: 6.5)', '2 years', 'Teaching English, listening to music, play game', 'English teacher'),
]);

List<LanguageDTO> listLanguageDTO = [LanguageDTO(1, 1, 'English'), LanguageDTO(2, 1, 'Vietnamese'),
                                      LanguageDTO(3, 2, 'English'), LanguageDTO(4, 2, 'Tagalog'),
                                      LanguageDTO(5, 3, 'English'), LanguageDTO(6, 3, 'Japanese'), LanguageDTO(7, 3, 'Vietnamese'),];

List<SpecialtyDTO> listSpecialtyDTO = [SpecialtyDTO(1, 1, 'English for Kids'), SpecialtyDTO(2, 1, 'Conversational English'),
                                       SpecialtyDTO(3, 2, 'Conversational English'),  SpecialtyDTO(4, 2, 'IELTS'),
                                       SpecialtyDTO(5, 3, 'English for Kids'),  SpecialtyDTO(6, 3, 'IELTS'),];

ListCommentDTO listCommentDTO = ListCommentDTO([
  CommentDTO(1, 1, 'Good', DateTime(2021, 11, 27, 9, 20)),
  CommentDTO(2, 1, 'Happy', DateTime(2021, 11, 27, 10, 30)),
  CommentDTO(3, 2, 'Very good', DateTime(2021, 11, 27, 13, 20)),
  CommentDTO(4, 3, 'Very fun', DateTime(2021, 11, 28, 10, 35)),
]);