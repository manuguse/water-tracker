import 'package:agua_diaria/functions/drink_helper.dart';
import 'package:agua_diaria/values/enums.dart';
import 'package:agua_diaria/widgets/value_selector.dart';
import 'package:flutter/material.dart';

class RecommendedAmount extends StatefulWidget {
  const RecommendedAmount({super.key});

  @override
  State<RecommendedAmount> createState() => _RecommendedAmountState();
}

class _RecommendedAmountState extends State<RecommendedAmount> {
  var _biologicSex = BiologicSex.female;
  var _hour = Hour.halfHour;

  final kgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'quantidade diária recomendada',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Column(
                children: [
                  const Text('sexo biológico'),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ValueSelector<BiologicSex>(
                        value: _biologicSex,
                        valueMap: const {
                          BiologicSex.female: 'feminino',
                          BiologicSex.male: 'masculino'
                        },
                        onSelect: (value) {
                          setState(() {
                            _biologicSex = value;
                          });
                        }),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('peso'),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 48,
                      child: TextField(
                        controller: kgController,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text('kg'),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF3688D3), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF3688D3), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        ),
                      )),
                ],
              ),
              Column(
                children: [
                  const Text('exercícios diários'),
                  const SizedBox(
                    height: 12,
                  ),
                  ValueSelector<Hour>(
                    value: _hour,
                    valueMap: const {
                      Hour.zeroHour: '0 min',
                      Hour.halfHour: '30 min',
                      Hour.oneHour: '1 hora',
                      Hour.twoHour: '2 horas',
                      Hour.threeHour: '3 horas',
                      Hour.fourPlusHour: '4+ horas',
                    },
                    onSelect: (value) {
                      setState(() {
                        _hour = value;
                      });
                    },
                    paddingHorizontal: 20,
                  ),
                ],
              ),
              TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF3688D3)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side:
                                  const BorderSide(color: Color(0xFF3688D3))))),
                  child: const Text(
                    "calcular",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {}),
              Column(
                children: [
                  Text(
                    'é recomendado que você tome\n${(calculateWater(weight: 100, exercisesInMinutes: 3 * 60, biologicSex: _biologicSex)).toStringAsFixed(1)} litros de água diariamente :)',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'definir como meta',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3688D3),
                        fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}