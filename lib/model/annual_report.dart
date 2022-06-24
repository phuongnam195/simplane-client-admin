import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplane_client_admin/model/monthly_report.dart';

part 'annual_report.g.dart';

@JsonSerializable()
class AnnualReport extends Equatable {
  final int year;
  final List<MonthlyReport> monthlyReports; // 0-11 (1-12)
  final String? staffId;

  const AnnualReport(this.year, this.monthlyReports, [this.staffId]);

  factory AnnualReport.fromJson(Map<String, dynamic> json) =>
      _$AnnualReportFromJson(json);

  Map<String, dynamic> toJson() => _$AnnualReportToJson(this);

  @override
  List<Object?> get props => [year, monthlyReports, staffId];

  @override
  bool get stringify => true;

  int? get totalFlight {
    if (staffId != null) return null;
    int s = 0;
    for (MonthlyReport report in monthlyReports) {
      s += report.flightCount!;
    }
    return s;
  }

  int get totalTicket {
    int s = 0;
    for (MonthlyReport report in monthlyReports) {
      s += report.ticketCount;
    }
    return s;
  }
}
