import 'dart:io';

import 'package:staff_flow_server/staff_flow_server.dart';

/// Facture d'exemple (aperçu) : `dart run tool/sample_invoice.dart fichier.pdf`
Future<void> main(List<String> args) async {
  final bytes = await BillingService.renderInvoice([
    'SF-2026-000001', 'Кав\'ярня «Каштан»', 'Олена Коваленко', 'olena@example.com',
    DateTime.utc(2026, 10, 11), 'year', DateTime.utc(2026, 10, 11), DateTime.utc(2027, 10, 11), 25,
    [
      {'label': 'subscription', 'staff': 25, 'period': 'year', 'unitCents': 500, 'months': 12, 'paidMonths': 10, 'cents': 5000},
      {'label': 'cascade', 'unitCents': 200, 'months': 12, 'cents': 2400},
    ],
    7400, 'test',
  ]);
  File(args.first).writeAsBytesSync(bytes);
}
