import 'package:let_tutor/model/booking_dto.dart';
import 'package:let_tutor/model/comment_dto.dart';
import 'package:let_tutor/model/course_dto.dart';
import 'package:let_tutor/model/feedback_dto.dart';
import 'package:let_tutor/model/language_dto.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/list_comment_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/specialty_dto.dart';
import 'package:let_tutor/model/topic_dto.dart';
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

List<CourseDTO> listCourseDTO = [CourseDTO(1, 'images/course_picture.png', 'Basic Conversation Topics', 'Gain confidence speaking about familiar topics',
                                  "It can be intimidating to speak with a foreigner, no matter how much grammar and vocabulary you've mastered. If you have basic knowledge of English but have not spent much time speaking, this course will help you ease into your first English conversations.",
                                  'This course covers vocabulary at the CEFR A2 level. You will build confidence while learning to speak about a variety of common, everyday topics. In addition, you will build implicit grammar knowledge as your tutor models correct answers and corrects your mistakes.',
                                  'Beginner', 10),
                                CourseDTO(2, 'images/course_picture2.png', 'Healthy Mind, Healthy Body', "Let's discuss the many aspects of living a long, happy life", 
                                  "", 'Discuss topics related to physical, mental, and emotional health. Learn about other cultures along the way in friendly conversations with tutors.',
                                  'Intermediate', 6)];

List<TopicDTO> listTopicDTO = [TopicDTO(1, 1, 'Foods You Love'), TopicDTO(2, 1, 'Your Job'),
                                TopicDTO(3, 1, 'Playing and Watching Sports'), TopicDTO(4, 1, 'The Best Pet'), 
                                TopicDTO(5, 1, 'Having Fun in Your Free Time'), TopicDTO(6, 1, 'Your Daily Routine'),
                                TopicDTO(7, 1, 'Childhood Memories'), TopicDTO(8, 1, 'Your Family Members'),
                                TopicDTO(9, 1, 'Your Hometown'), TopicDTO(10, 1, 'Shopping Habits'),
                                
                                TopicDTO(11, 2, 'You Are What You Eat'), TopicDTO(12, 2, 'Health and Fitness'),
                                TopicDTO(13, 2, 'Drink Up'), TopicDTO(14, 2, 'Getting Some Zizz'), 
                                TopicDTO(15, 2, 'Calm and RnB'), TopicDTO(16, 2, 'Look On The Bright Side'),
                                ];

List<FeedbackDTO> listFeedbackDTO = [FeedbackDTO(1, 2, 5, 'Thank you for booking my class. I hope to see you again soon. Keep learning the language.', DateTime(2021, 11, 29, 8, 30, 2, 0, 0),),
                                    FeedbackDTO(2, 3, 5, 'Thank you for booking my class. I hope to see you again soon.', DateTime(2021, 11, 30, 11, 30, 0, 0, 0),),
                                    ];

ListBookingDTO listBookingDTO = ListBookingDTO([BookingDTO(1, 1, DateTime(2021, 11, 28, 8, 0, 0, 0, 0), DateTime(2021, 11, 28, 8, 25, 0, 0, 0), false, false),
                                              BookingDTO(2, 2, DateTime(2021, 11, 29, 8, 0, 0, 0, 0), DateTime(2021, 11, 28, 8, 30, 0, 0, 0), false, false),
                                              BookingDTO(3, 3, DateTime(2021, 11, 30, 11, 0, 0, 0, 0), DateTime(2021, 11, 30, 11, 25, 0, 0, 0), false, false),]);