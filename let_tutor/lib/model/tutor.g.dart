// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tutor _$TutorFromJson(Map<String, dynamic> json) => Tutor(
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      country: json['country'] as String?,
      feedbacks: (json['feedbacks'] as List<dynamic>?)
          ?.map((e) => Feedback.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['userId'] as String?,
      bio: json['bio'] as String?,
      languages: json['languages'] as String?,
      specialties: json['specialties'] as String?,
    );

Map<String, dynamic> _$TutorToJson(Tutor instance) => <String, dynamic>{
      'avatar': instance.avatar,
      'name': instance.name,
      'country': instance.country,
      'feedbacks': instance.feedbacks,
      'userId': instance.userId,
      'bio': instance.bio,
      'languages': instance.languages,
      'specialties': instance.specialties,
    };
