import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String username;
  final String fullname;
  final bool isVerified;
  final String accessToken;
  final bool isAdmin;

  const User(
      this.id, this.username, this.fullname, this.isVerified, this.accessToken,
      [this.isAdmin = false]);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props =>
      [id, username, fullname, isVerified, accessToken, isAdmin];

  @override
  bool get stringify => true;
}
