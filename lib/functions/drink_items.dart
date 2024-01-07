import 'package:agua_diaria/models/drink_history.dart';
import 'package:agua_diaria/values/enums.dart';

Map<Drink, List<DrinkHistory>> getDrinkItemsByDrinkType(
    List<DrinkHistory> items) {
  final Map<Drink, List<DrinkHistory>> mapItems = {};
  for (final item in items) {
    final listItems = mapItems[item.drink] ?? [];
    listItems.add(item);
    mapItems[item.drink] = listItems;
  }
  return mapItems;
}