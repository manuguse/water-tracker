import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFDCE5F1),
        textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color(0xFF020A0F), fontSize: 16))),
    home: const GoalScreen(),
  ));
}

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final drinkItems = [
    DrinkItem('água', 'water.svg'),
    DrinkItem('café', 'coffee.svg'),
    DrinkItem('chá', 'tea.svg'),
    DrinkItem('refrigerante', 'soda.svg'),
    DrinkItem('suco', 'juice.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'consumo do dia',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '1200/3900',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('adição rápida'),
                  const SizedBox(
                    height: 16,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              drinkItems.map((e) => getDrinkItems(e)).toList(),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const RecommendedAmount()));
                          },
                          child: const Text(
                            'descubra a quantidade\nrecomendada para você',
                            style: TextStyle(
                                color: Color(0xFF3688D3),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                    )))
          ],
        ),
      ),
    );
  }

  Widget getDrinkItems(DrinkItem item) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                  color: Color(0xFF3688D3),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: SvgPicture.asset(item.path),
                  )),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              item.type,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      );
}

class DrinkItem {
  final String type, fileName;

  String get path => '$pathToDrinkAssets/$fileName';
  static const pathToDrinkAssets = 'assets/drinks';

  DrinkItem(this.type, this.fileName);
}

class RecommendedAmount extends StatefulWidget {
  const RecommendedAmount({super.key});

  @override
  State<RecommendedAmount> createState() => _RecommendedAmountState();
}

class _RecommendedAmountState extends State<RecommendedAmount> {
  var _biologicSex = BiologicSex.female;
  var _hour = Hour.halfHour;

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
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          suffix: Text(
                            'kg',
                            style: TextStyle(fontSize: 12),
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
              //TODO botao calcular
              TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
                      foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF3688D3)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Color(0xFF3688D3))
                          )
                      )
                  ),
                  child: const Text(
                    "calcular",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => null
              ),
              Column(
                children: [
                  Text(
                    'é recomendado que você tome\n${calculateWater(60, 40)} litros de água diariamente :)',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'definir como meta',
                    style: const TextStyle(
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

class ValueSelector<T> extends StatefulWidget {
  final T value;
  final Map<T, String> valueMap;
  final Null Function(T value) onSelect;
  final double paddingHorizontal;

  const ValueSelector(
      {super.key,
      required this.value,
      required this.valueMap,
      required this.onSelect,
      this.paddingHorizontal = 0})
      : assert(
            valueMap.length >= 2, 'The valueMap\'s size must be at least 2.');

  @override
  State<ValueSelector<T>> createState() => _ValueSelectorState<T>();
}

class _ValueSelectorState<T> extends State<ValueSelector<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.valueMap.length == 2) {
      return Row(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => widget.onSelect(widget.valueMap.keys.first),
              child: Container(
                decoration: BoxDecoration(
                    color: widget.value == widget.valueMap.keys.first
                        ? const Color(0xFF3688D3)
                        : const Color(0xFF97C5EF),
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(30))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      widget.valueMap.values.first,
                      style: TextStyle(
                          fontSize: 16,
                          color: widget.value == widget.valueMap.keys.first
                              ? Colors.white
                              : null),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => widget.onSelect(widget.valueMap.keys.last),
              child: Container(
                decoration: BoxDecoration(
                    color: widget.value == widget.valueMap.keys.last
                        ? const Color(0xFF3688D3)
                        : const Color(0xFF97C5EF),
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(30))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      widget.valueMap.values.last,
                      style: TextStyle(
                          fontSize: 16,
                          color: widget.value == widget.valueMap.keys.last
                              ? Colors.white
                              : null),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            SizedBox(
              width: widget.paddingHorizontal,
            ),
            Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.valueMap.entries.map((e) {
                  final key = GlobalKey();
                  return Padding(
                    key: key,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: GestureDetector(
                      onTap: () {
                        if (key.currentContext != null) {
                          Scrollable.ensureVisible(key.currentContext!,
                              duration: const Duration(milliseconds: 750));
                        }

                        widget.onSelect(e.key);
                      },
                      child: Container(
                        // padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: widget.value == e.key
                                ? const Color(0xFF3688D3)
                                : const Color(0xFF97C5EF),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              e.value,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: widget.value == e.key
                                      ? Colors.white
                                      : null),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList()),
            SizedBox(
              width: widget.paddingHorizontal,
            ),
          ],
        ),
      );
    }
  }
}

enum BiologicSex {
  male,
  female;
}

enum Hour {
  zeroHour,
  halfHour,
  oneHour,
  twoHour,
  threeHour,
  fourPlusHour;
}

double calculateWater(int peso, int exerciciosMinutos) {
  //return 0;
  return (1.1*peso + exerciciosMinutos*12/30)*0.03;
}