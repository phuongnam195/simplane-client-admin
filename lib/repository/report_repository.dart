import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/annual_report.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

import '../dummy_data.dart';

abstract class ReportRepository extends BaseRepository<AnnualReport> {
  Future<AnnualReport> getReport(int year, [String? staffId]);

  Future<double> getTotalTicketCount([String? staffId]);

  Future<double> getTotalRevenue([String? staffId]);
}

class ReportRepositoryImp extends BaseRepositoryImp<AnnualReport>
    implements ReportRepository {
  @override
  Future<AnnualReport> getReport(int year, [String? staffId]) async {
    if (staffId == null) {
      return managerReportsDummy.firstWhere(
        (e) => e.year == year,
        orElse: () => AnnualReport(year, const []),
      );
    } else {
      return staffReportsDummy.firstWhere(
        (e) => e.year == year,
        orElse: () => AnnualReport(year, const []),
      );
    }

    // TODO: api

    // return AnnualReport.fromJson(await ApiClient(REPORT_GET).get(
    //     params: {'year': year, 'staffId': staffId}
    //       ..removeWhere((_, v) => v == null)));
  }

  @override
  Future<double> getTotalTicketCount([String? staffId]) async {
    // TODO: api

    double result = 0;
    for (var annualReport in staffReportsDummy) {
      for (var monthlyReport in annualReport.monthlyReports) {
        result += monthlyReport.ticketCount;
      }
    }

    return result;
  }

  @override
  Future<double> getTotalRevenue([String? staffId]) async {
    // TODO: api

    double result = 0;
    for (var annualReport in staffReportsDummy) {
      for (var monthlyReport in annualReport.monthlyReports) {
        result += monthlyReport.revenue;
      }
    }

    return result;
  }
}
