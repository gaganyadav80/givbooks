// ignore_for_file: constant_identifier_names

import 'package:get_storage/get_storage.dart';

class DBHelper {
  static late GetStorage db;

  static List<String> get getShelves => List<String>.from(db.read(SHELVES_KEY));
  static void setShelves(List<String> shelves) async => await db.write(SHELVES_KEY, shelves);

  static const String DB_KEY = "GIVBOOKS_DB";
  static const String SHELVES_KEY = "GIVBOOKS_SHELVES";
}
