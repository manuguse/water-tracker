import 'package:agua_diaria/values/enums.dart';

const Map<Drink, String> drinkDict = {
      Drink.water: 'Água',
      Drink.coffee: 'Café',
      Drink.tea: 'Chá',
      Drink.soda: 'Refri',
      Drink.juice: 'Suco',
    };

const Map<Hour, int> hourDict = {
      Hour.zeroHour: 0,
      Hour.halfHour: 30,
      Hour.oneHour: 60,
      Hour.twoHour: 120,
      Hour.threeHour: 180,
      Hour.fourPlusHour: 240
    };
