import 'package:agua_diaria/functions/database.dart';
import 'package:agua_diaria/models/drink_item.dart';
import 'package:agua_diaria/values/dicts.dart';
import 'package:agua_diaria/values/enums.dart';
import 'package:agua_diaria/views/recommended_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  Widget build(BuildContext context) {
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
                          return Text(
                            '$amount/3900',
                            style: const TextStyle(fontSize: 40),
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
                            await Navigator.of(context).push<bool>(
                                MaterialPageRoute(
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
