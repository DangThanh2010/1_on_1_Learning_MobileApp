import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/tokens.dart';
import 'package:let_tutor/model/user.dart';

part 'user_tokens.g.dart';

@JsonSerializable()
class UserTokens {
  User? user;
  Tokens? tokens;

  UserTokens({this.user, this.tokens});

  factory UserTokens.fromJson(Map<String, dynamic> json) => _$UserTokensFromJson(json);

  Map<String, dynamic> toJson() => _$UserTokensToJson(this);
}