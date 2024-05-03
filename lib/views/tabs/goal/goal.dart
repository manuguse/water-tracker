import 'package:agua_diaria/functions/alarm.dart';
import 'package:agua_diaria/functions/database.dart';
import 'package:agua_diaria/models/drink_item.dart';
import 'package:agua_diaria/models/goal_amount.dart';
import 'package:agua_diaria/values/dicts.dart';
import 'package:agua_diaria/values/enums.dart';
import 'package:agua_diaria/views/tabs/goal/recommended_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'add_drink.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  late Future<int> drinkAmountHistory;

  @override
  void initState() {
    drinkAmountHistory = getDrinkAmountHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext contextcontext) {
    final goalAmount = context.watch<GoalAmount>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'consumo do dia',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FutureBuilder<int>(
                      future: drinkAmountHistory,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          final amount = snapshot.data;
                          return Column(
                            children: [
                              Text(
                                '${(amount! / goalAmount.amount * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(fontSize: 72),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '$amount/${goalAmount.amount} ml',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('adição rápida'),
                  TextButton(
                      onPressed: () async {
                        await setAlarm(0);
                      },
                      child: Text('OI MAMÃE')),
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
                          children: Drink.values.map((e) {
                            final drinkItem = DrinkItem(
                                e, '${e.toString().split('.')[1]}.svg');
                            return GestureDetector(
                                onTap: () async {
                                  final added = await _showDrinkDialog(
                                      context, drinkItem);
                                  if (added == true) {
                                    setState(() {
                                      drinkAmountHistory =
                                          getDrinkAmountHistory();
                                    });
                                  }
                                },
                                child: getDrinkItems(drinkItem));
                          }).toList(),
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
                          onTap: () async {
                            final goalAmountValue = await Navigator.of(context)
                                .push<int>(MaterialPageRoute(
                                    builder: (context) =>
                                        const RecommendedAmount()));
                            if (goalAmountValue != null) {
                              goalAmount.amount = goalAmountValue;
                            }
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

  static Future<void> printHello(int id) async {
    print(id);
    print('tic tac');
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
              drinkDict[item.type]?.toLowerCase() ?? '',
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      );

  Future<bool?> _showDrinkDialog(
      BuildContext context, DrinkItem drinkItem) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Dialog(
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFF3688D3), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: AddDrinkDialog(
              drinkItem: drinkItem,
            ),
          ),
        );
      },
    );
  }
}
