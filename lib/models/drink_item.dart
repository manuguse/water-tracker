import 'package:agua_diaria/values/enums.dart';

class DrinkItem {
  final Drink type;
  final String fileName;

  String get path => '$pathToDrinkAssets/$fileName';
  static const pathToDrinkAssets = 'assets/drinks';

  DrinkItem(this.type, this.fileName);
}
