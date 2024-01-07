import 'package:agua_diaria/models/drink_history.dart';
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
      strftime('%Y-%m-%d', date / 1000, 'unixepoch') = strftime('%Y-%m-%d', ${now.millisecondsSinceEpoch} / 1000, 'unixepoch');""");
  return snapshot.first['amount'] as int;
}

Future<Map<int, Map<DateTime, List<DrinkHistory>>>> getDrinkHistory() async {
  final database = await getDatabase();
  final snapshot = await database.rawQuery(
      """select date, amount, type from drink_history order by date desc;""");
  final Map<int, Map<DateTime, List<DrinkHistory>>> items = {};
  for (final item in snapshot) {
    final drinkHistoryItem = DrinkHistory.fromJson(item);
    //Testar se vai funcionar.
    final dayTime = DateTime(drinkHistoryItem.date.year,
        drinkHistoryItem.date.month, drinkHistoryItem.date.day);
    final mapFromYear = items[dayTime.year] ?? {};
    final listToAdd = mapFromYear[dayTime] ?? [];
    listToAdd.add(drinkHistoryItem);
    mapFromYear[dayTime] = listToAdd;
    items[dayTime.year] = mapFromYear;
  }
  return items;
}
