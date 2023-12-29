import 'package:agua_diaria/values/database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const databaseVersion = 1;

Future<Database> getDatabase() async {
  final database = openDatabase(
      join(await getDatabasesPath(), 'drink_water.db'),
      version: databaseVersion, onCreate: (database, version) async {
    for (final query in onCreateDatabase) {
      await database.rawQuery(query);
    }
  });
  return database;
}

Future<int> getDrinkAmountHistory() async {
  final database = await getDatabase();
  final now = DateTime.now();
  final snapshot =
      await database.rawQuery("""select coalesce(sum(amount), 0) amount 
      from drink_history where
      strftime('%Y-%m-%d', date / 1000, 'unixepoch') = strftime('%Y-%m-%d', ${now.millisecondsSinceEpoch} / 1000, 'unixepoch') ;""");
  return snapshot.first['amount'] as int;
}
