import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airport.g.dart';

@JsonSerializable()
class Airport extends Equatable {
  final String code;
  final String name;
  final String address;

  const Airport(this.code, this.name, this.address);

  factory Airport.fromJson(Map<String, dynamic> json) =>
      _$AirportFromJson(json);

  Map<String, dynamic> toJson() => _$AirportToJson(this);

  @override
  List<Object> get props => [code, name, address];

  @override
  bool get stringify => true;
}
