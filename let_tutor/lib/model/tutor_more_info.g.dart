// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_more_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorMoreInfo _$TutorMoreInfoFromJson(Map<String, dynamic> json) =>
    TutorMoreInfo(
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      country: json['country'] as String?,
      feedbacks: (json['feedbacks'] as List<dynamic>?)
          ?.map((e) => FeedbackDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TutorMoreInfoToJson(TutorMoreInfo instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'name': instance.name,
      'country': instance.country,
      'feedbacks': instance.feedbacks,
    };
