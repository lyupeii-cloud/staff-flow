import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

/// Base locale de l'appareil (Android) : un fichier dans les données de l'application.
Future<Database> openLocalDb() async {
  final dir = await getApplicationSupportDirectory();
  return databaseFactoryIo.openDatabase('${dir.path}/staff_flow.db');
}
