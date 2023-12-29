import 'package:agua_diaria/values/dicts.dart';
import 'package:agua_diaria/values/enums.dart';

double calculateWater(
    {required int weight,
    required Hour exercisesInMinutes,
    required BiologicSex biologicSex}) {
  return (1.1 * weight + hourDict[exercisesInMinutes]! * 12 / 30) *
      0.03 *
      (biologicSex == BiologicSex.female ? 1 : 1.15);
}
