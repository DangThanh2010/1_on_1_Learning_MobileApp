import 'package:let_tutor/model/booking_dto.dart';
import 'package:let_tutor/model/comment_dto.dart';
import 'package:let_tutor/model/feedback_dto.dart';
import 'package:let_tutor/model/language_dto.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/list_comment_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/schedule_dto.dart';
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
  CommentDTO(1, 1, 4, 'Good', DateTime(2021, 11, 27, 9, 20)),
  CommentDTO(2, 1, 5, 'Happy', DateTime(2021, 11, 27, 10, 30)),
  CommentDTO(3, 2, 4, 'Very good', DateTime(2021, 11, 27, 13, 20)),
  CommentDTO(4, 3, 5,'Very fun', DateTime(2021, 11, 28, 10, 35)),
]);

List<FeedbackDTO> listFeedbackDTO = [FeedbackDTO(1, 2, 5, 'Thank you for booking my class. I hope to see you again soon. Keep learning the language.', DateTime(2021, 11, 29, 8, 30, 2, 0, 0),),
                                    FeedbackDTO(2, 3, 5, 'Thank you for booking my class. I hope to see you again soon.', DateTime(2021, 11, 30, 11, 30, 0, 0, 0),),
                                    ];

ListBookingDTO listBookingDTO = ListBookingDTO([BookingDTO(1, 1, DateTime(2021, 11, 28, 8, 0, 0, 0, 0), DateTime(2021, 11, 28, 8, 25, 0, 0, 0), false, false),
                                              BookingDTO(2, 2, DateTime(2021, 12, 28, 8, 0, 0, 0, 0), DateTime(2021, 12, 28, 8, 30, 0, 0, 0), false, false),
                                              BookingDTO(3, 3, DateTime(2021, 12, 29, 7, 5, 0, 0, 0), DateTime(2021, 12, 29, 7, 30, 0, 0, 0), false, false),]);

List<ScheduleDTO> listScheduleDTO = [ScheduleDTO(1, 1, DateTime(2021, 12, 27, 8, 0, 0, 0, 0), DateTime(2021, 12, 27, 8, 30, 0, 0, 0)),
                                    ScheduleDTO(2, 1, DateTime(2021, 12, 27, 10, 15, 0, 0, 0), DateTime(2021, 12, 27, 10, 40, 0, 0, 0)),
                                    ScheduleDTO(3, 1, DateTime(2021, 12, 28, 12, 0, 0, 0, 0), DateTime(2021, 12, 28, 12, 30, 0, 0, 0)),
                                    ScheduleDTO(4, 1, DateTime(2021, 12, 29, 20, 5, 0, 0, 0), DateTime(2021, 12, 27, 20, 30, 0, 0, 0)),
                                    ScheduleDTO(5, 2, DateTime(2021, 12, 27, 9, 0, 0, 0, 0), DateTime(2021, 12, 27, 9, 30, 0, 0, 0)),
                                    ScheduleDTO(6, 2, DateTime(2021, 12, 28, 8, 0, 0, 0, 0), DateTime(2021, 12, 28, 8, 30, 0, 0, 0)),
                                    ScheduleDTO(7, 2, DateTime(2021, 12, 28, 15, 10, 0, 0, 0), DateTime(2021, 12, 28, 15, 35, 0, 0, 0)),
                                    ScheduleDTO(8, 2, DateTime(2021, 12, 29, 10, 5, 0, 0, 0), DateTime(2021, 12, 29, 10, 45, 0, 0, 0)),
                                    ScheduleDTO(9, 3, DateTime(2021, 12, 27, 10, 0, 0, 0, 0), DateTime(2021, 12, 27, 10, 30, 0, 0, 0)),
                                    ScheduleDTO(10, 3, DateTime(2021, 12, 28, 11, 0, 0, 0, 0), DateTime(2021, 12, 28, 11, 25, 0, 0, 0)),
                                    ScheduleDTO(11, 3, DateTime(2021, 12, 29, 7, 5, 0, 0, 0), DateTime(2021, 12, 29, 7, 30, 0, 0, 0)),
                                    ScheduleDTO(12, 3, DateTime(2021, 12, 29, 12, 0, 0, 0, 0), DateTime(2021, 12, 29, 12, 30, 0, 0, 0)),
                                    ];