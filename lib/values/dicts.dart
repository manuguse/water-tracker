import 'package:agua_diaria/values/enums.dart';

Map<Drink, String> get drinkDict => {
      Drink.water: 'Água',
      Drink.coffee: 'Café',
      Drink.tea: 'Chá',
      Drink.soda: 'Refrigerante',
      Drink.juice: 'Suco',
    };

Map<Hour, int> get hourDict => {
      Hour.zeroHour: 0,
      Hour.halfHour: 30,
      Hour.oneHour: 60,
      Hour.twoHour: 120,
      Hour.threeHour: 180,
      Hour.fourPlusHour: 240
    };
