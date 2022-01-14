// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackDetail _$FeedbackDetailFromJson(Map<String, dynamic> json) =>
    FeedbackDetail(
      rating: json['rating'] as int?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      firstInfo: json['firstInfo'] == null
          ? null
          : FeedbackUserInfo.fromJson(
              json['firstInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedbackDetailToJson(FeedbackDetail instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'firstInfo': instance.firstInfo,
    };
