import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:simplane_client_admin/util/utils.dart';

import '../core/user_manager.dart';
import '../generated/l10n.dart';
import '../model/annual_report.dart';

class PdfUtils {
  static Future<File> generateReport(AnnualReport? report) async {
    final pdf = Document();
    var headers = [];
    List<List<Object?>> data;
    if (UserManager.instance.getUser()?.isAdmin == true) {
      headers = ['Month', 'Number of flights', 'Number of tickets', 'Revenue'];
      data = report!.monthlyReports
          .map((rp) => [
                rp.month,
                rp.flightCount,
                rp.ticketCount,
                formatCurrencyPdf(rp.revenue)
              ])
          .toList();
    } else {
      headers = ['Month', 'Number of tickets', 'Revenue'];
      data = report!.monthlyReports
          .map(
              (rp) => [rp.month, rp.ticketCount, formatCurrencyPdf(rp.revenue)])
          .toList();
    }

    pdf.addPage(Page(
        pageTheme: const PageTheme(),
        build: (context) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                      S.current.annual_revenue_report.toUpperCase() +
                          (' ${report.year}'),
                      style: TextStyle(font: Font.timesBold(), fontSize: 25)),
                ),
                Table.fromTextArray(
                  headers: headers,
                  headerStyle: TextStyle(font: Font.timesBold(), fontSize: 15),
                  data: data,
                ),
              ],
            )));

    return saveDocument(name: 'report.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
