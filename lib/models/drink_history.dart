import 'package:agua_diaria/functions/database.dart';
import 'package:agua_diaria/values/enums.dart';

class DrinkHistory {
  final int? id;
  final DateTime date;
  final int drinkAmount;
  final Drink drink;

  DrinkHistory(
      {this.id, required this.date,
      required this.drinkAmount,
      required this.drink});

  DrinkHistory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = DateTime.fromMillisecondsSinceEpoch(json['date']),
        drinkAmount = json['amount'],
        drink = Drink.values[json['type']];

  Map<String, dynamic> get databaseJson => {
        'date': date.millisecondsSinceEpoch,
        'amount': drinkAmount,
        'type': Drink.values.indexOf(drink),
      };

  Future<void> saveOnDatabase() async {
    final database = await getDatabase();
    await database.insert('drink_history', databaseJson);
  }
}
