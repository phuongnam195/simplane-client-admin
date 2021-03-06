import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'monthly_report.g.dart';

@JsonSerializable()
class MonthlyReport extends Equatable {
  final int? staffId;
  final int year;
  final int month;
  final int? flightCount;
  final int ticketCount;
  final double revenue;

  const MonthlyReport({
    this.staffId,
    required this.year,
    required this.month,
    this.flightCount,
    required this.ticketCount,
    required this.revenue,
  }) : assert(!((staffId == null) ^ (flightCount != null)));

  factory MonthlyReport.fromJson(Map<String, dynamic> json) =>
      _$MonthlyReportFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyReportToJson(this);

  @override
  List<Object?> get props =>
      [staffId, year, month, flightCount, ticketCount, revenue];

  @override
  bool get stringify => true;
}
