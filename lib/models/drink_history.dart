import 'package:agua_diaria/functions/database.dart';
import 'package:agua_diaria/values/enums.dart';

class DrinkHistory {
  final DateTime day;
  final int drinkAmount;
  final Drink drink;

  DrinkHistory(
      {required this.day, required this.drinkAmount, required this.drink});

  Map<String, dynamic> get databaseJson => {
        'date': day.millisecondsSinceEpoch,
        'amount': drinkAmount,
        'type': Drink.values.indexOf(drink),
      };

  Future<void> saveOnDatabase() async {
    final database = await getDatabase();
    await database.insert('drink_history', databaseJson);
  }
}
