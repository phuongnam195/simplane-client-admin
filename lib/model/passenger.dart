import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'passenger.g.dart';

@JsonSerializable()
class Passenger extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String identityNumber;
  final String email;
  final String phoneNumber;

  const Passenger(this.id, this.firstName, this.lastName, this.identityNumber,
      this.email, this.phoneNumber);

  factory Passenger.fromJson(Map<String, dynamic> json) =>
      _$PassengerFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerToJson(this);

  @override
  List<Object> get props =>
      [id, firstName, lastName, identityNumber, email, phoneNumber];

  @override
  bool get stringify => true;
}
