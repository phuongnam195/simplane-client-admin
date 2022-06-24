import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/annual_report.dart';
import 'package:simplane_client_admin/model/staff.dart';

import '../dummy_data.dart';

abstract class StaffRepository extends BaseRepository<Staff> {
  Future<List<Staff>> getStaffs();

  Future removeStaff(String id);

  // Future<double> getTotalTicketCount([String? staffId]);

  // Future<double> getTotalRevenue([String? staffId]);
}

class StaffRepositoryImp extends BaseRepositoryImp<Staff>
    implements StaffRepository {
  @override
  Future<List<Staff>> getStaffs() async {
    // Chưa có API
    return staffsDummy;
  }

  @override
  Future removeStaff(String id) async {
    // Chưa có API
    staffsDummy.removeWhere((e) => e.id == id);
  }

  // @override
  // Future<double> getTotalTicketCount([String? staffId]) async {
  //   // TODO: api

  //   double result = 0;
  //   for (var annualReport in staffReportsDummy) {
  //     for (var monthlyReport in annualReport.monthlyReports) {
  //       result += monthlyReport.ticketCount;
  //     }
  //   }

  //   return result;
  // }

  // @override
  // Future<double> getTotalRevenue([String? staffId]) async {
  //   // TODO: api

  //   double result = 0;
  //   for (var annualReport in staffReportsDummy) {
  //     for (var monthlyReport in annualReport.monthlyReports) {
  //       result += monthlyReport.revenue;
  //     }
  //   }

  //   return result;
  // }
}
