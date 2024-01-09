import 'package:agua_diaria/functions/drink_helper.dart';
import 'package:agua_diaria/models/goal_amount.dart';
import 'package:agua_diaria/values/enums.dart';
import 'package:agua_diaria/views/goal.dart';
import 'package:agua_diaria/widgets/value_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendedAmount extends StatefulWidget {
  final bool first;

  const RecommendedAmount({super.key, this.first = false});

  @override
  State<RecommendedAmount> createState() => _RecommendedAmountState();
}

class _RecommendedAmountState extends State<RecommendedAmount> {
  var _biologicSex = BiologicSex.female;
  var _hour = Hour.halfHour;
  double? calculatedWater;
  final kgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
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
                            inputFormatters: [
                              MyFormatter.allow(RegExp(r'[0-9.,]')),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                final text = newValue.text;
                                return text.isEmpty
                                    ? newValue
                                    : !RegExp(r"^[0-9]{1,3}([.,][0-9]?)?$")
                                            .hasMatch(text)
                                        ? oldValue
                                        : newValue;
                              }),
                            ],
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: const BorderSide(
                                          color: Color(0xFF3688D3))))),
                      child: const Text(
                        "calcular",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        final kg = double.tryParse(kgController.text.replaceAll(',', '.'));
                        if (kg != null) {
                          setState(() {
                            calculatedWater = calculateWater(
                                weight: kg,
                                exercisesInMinutes: _hour,
                                biologicSex: _biologicSex);
                          });
                        }
                      }),
                  if (calculatedWater != null)
                    Column(
                      children: [
                        Text(
                          'é recomendado que você tome\n${calculatedWater!.toStringAsFixed(1)} litros de água diariamente :)',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final goalAmount =
                                ((calculatedWater!*10).toInt() * 100);
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setInt('goalAmount', goalAmount);
                            if (widget.first) {
                              if (context.mounted) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ChangeNotifierProvider.value(
                                                value: GoalAmount(
                                                    amount: goalAmount),
                                                child: const GoalScreen())));
                              }
                            } else {
                              if (mounted) {
                                Navigator.of(context).pop<int>(goalAmount);
                              }
                            }
                          },
                          child: const Text(
                            'definir como meta',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3688D3),
                                fontSize: 12),
                          ),
                        )
                      ],
                    )
                ],
              ),
              const BackButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyFormatter extends FilteringTextInputFormatter {
  MyFormatter.allow(Pattern filterPattern) : super.allow(filterPattern);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final updatedValue = super.formatEditUpdate(oldValue, newValue);

    return updatedValue.text.isEmpty && newValue.text.isNotEmpty
        ? oldValue
        : updatedValue;
  }
}
