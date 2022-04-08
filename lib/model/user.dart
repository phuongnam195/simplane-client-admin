import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String username;
  final String fullname;
  final String accessToken;

  const User(this.id, this.username, this.fullname, this.accessToken);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [id, username, fullname, accessToken];

  @override
  bool get stringify => true;
}
