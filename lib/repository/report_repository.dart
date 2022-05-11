import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/annual_report.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

import '../dummy_data.dart';

abstract class ReportRepository extends BaseRepository<AnnualReport> {
  Future<AnnualReport> getReport(int year, [int? staffId]);
}

class ReportRepositoryImp extends BaseRepositoryImp<AnnualReport>
    implements ReportRepository {
  @override
  Future<AnnualReport> getReport(int year, [int? staffId]) async {
    return reportsDummy.firstWhere(
      (e) => e.year == year,
      orElse: () => AnnualReport(year, const []),
    );

    // TODO: api

    // return AnnualReport.fromJson(await ApiClient(REPORT_GET).get(
    //     params: {'year': year, 'staffId': staffId}
    //       ..removeWhere((_, v) => v == null)));
  }
}
