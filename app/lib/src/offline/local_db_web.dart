import 'package:sembast_web/sembast_web.dart';

/// Base locale du navigateur (IndexedDB).
Future<Database> openLocalDb() => databaseFactoryWeb.openDatabase('staff_flow');
