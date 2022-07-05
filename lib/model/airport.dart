import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airport.g.dart';

@JsonSerializable()
class Airport extends Equatable {
  final String id;
  final String code;
  final String name;
  final String address;

  const Airport(
      {this.id = '0',
      required this.code,
      required this.name,
      required this.address});

  factory Airport.fromJson(Map<String, dynamic> json) =>
      _$AirportFromJson(json);

  Map<String, dynamic> toJson() => _$AirportToJson(this);

  static List<Airport> mapToList(List<dynamic>? maps) {
    if (maps == null || maps.isEmpty) {
      return [];
    }

    return maps.map((data) => Airport.fromJson(data)).toList();
  }

  @override
  List<Object> get props => [id, code, name, address];

  @override
  bool get stringify => true;
}
