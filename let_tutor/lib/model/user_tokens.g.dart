// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTokens _$UserTokensFromJson(Map<String, dynamic> json) => UserTokens(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      tokens: json['tokens'] == null
          ? null
          : Tokens.fromJson(json['tokens'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserTokensToJson(UserTokens instance) =>
    <String, dynamic>{
      'user': instance.user,
      'tokens': instance.tokens,
    };
