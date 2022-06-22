import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'passenger.g.dart';

@JsonSerializable()
class Passenger extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String identityNumber;
  final String email;
  final String phoneNumber;

  const Passenger({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.identityNumber,
    required this.email,
    required this.phoneNumber,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) =>
      _$PassengerFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerToJson(this);

  @override
  List<Object> get props =>
      [id, firstName, lastName, identityNumber, email, phoneNumber];

  @override
  bool get stringify => true;

  String get name => firstName + ' ' + lastName;
}
