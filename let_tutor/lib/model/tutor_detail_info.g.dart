// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_detail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorDetailInfo _$TutorDetailInfoFromJson(Map<String, dynamic> json) =>
    TutorDetailInfo(
      userId: json['userId'] as String?,
      video: json['video'] as String?,
      bio: json['bio'] as String?,
      education: json['education'] as String?,
      experience: json['experience'] as String?,
      profession: json['profession'] as String?,
      targetStudent: json['targetStudent'] as String?,
      interests: json['interests'] as String?,
      languages: json['languages'] as String?,
      specialties: json['specialties'] as String?,
      user: json['user'] == null
          ? null
          : TutorMoreInfo.fromJson(json['user'] as Map<String, dynamic>),
      User: json['User'] == null
          ? null
          : TutorMoreInfo.fromJson(json['User'] as Map<String, dynamic>),
      isFavorite: json['isFavorite'] as bool?,
      avgRating: (json['avgRating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TutorDetailInfoToJson(TutorDetailInfo instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'video': instance.video,
      'bio': instance.bio,
      'education': instance.education,
      'experience': instance.experience,
      'profession': instance.profession,
      'targetStudent': instance.targetStudent,
      'interests': instance.interests,
      'languages': instance.languages,
      'specialties': instance.specialties,
      'user': instance.user,
      'User': instance.User,
      'isFavorite': instance.isFavorite,
      'avgRating': instance.avgRating,
    };
