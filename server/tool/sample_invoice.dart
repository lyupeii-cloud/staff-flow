import 'dart:io';

import 'package:staff_flow_server/staff_flow_server.dart';

/// Facture d'exemple (aperçu) : `dart run tool/sample_invoice.dart fichier.pdf langue`
Future<void> main(List<String> args) async {
  final bytes = await BillingService.renderInvoice([
    'SF-K7Q2MX-2026-0001', 'Кав\'ярня «Каштан»', 'Олена Коваленко', 'K7Q2MX',
    DateTime.utc(2026, 10, 20), 'year', DateTime.utc(2026, 10, 20), DateTime.utc(2027, 11, 1), 25,
    [
      {'label': 'prorata', 'staff': 25, 'days': 12, 'monthDays': 31, 'cents': 194},
      {'label': 'cascadeProrata', 'days': 12, 'monthDays': 31, 'cents': 78},
      {'label': 'subscription', 'staff': 25, 'period': 'year', 'unitCents': 500, 'months': 12, 'paidMonths': 10, 'cents': 5000},
      {'label': 'cascade', 'unitCents': 200, 'months': 12, 'cents': 2400},
    ],
    7672, 'test',
  ], args.length > 1 ? args[1] : 'fr');
  File(args.first).writeAsBytesSync(bytes);
}
