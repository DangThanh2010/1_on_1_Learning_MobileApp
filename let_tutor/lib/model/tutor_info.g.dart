// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorInfo _$TutorInfoFromJson(Map<String, dynamic> json) => TutorInfo(
      id: json['id'] as String?,
      level: json['level'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      country: json['country'] as String?,
      phone: json['phone'] as String?,
      birthday: json['birthday'] as String?,
      requestPassword: json['requestPassword'] as bool?,
      isActivated: json['isActivated'] as bool?,
      timezone: json['timezone'] as int?,
      isPhoneAuthActivated: json['isPhoneAuthActivated'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$TutorInfoToJson(TutorInfo instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'email': instance.email,
      'avatar': instance.avatar,
      'name': instance.name,
      'country': instance.country,
      'phone': instance.phone,
      'birthday': instance.birthday,
      'requestPassword': instance.requestPassword,
      'isActivated': instance.isActivated,
      'timezone': instance.timezone,
      'isPhoneAuthActivated': instance.isPhoneAuthActivated,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
