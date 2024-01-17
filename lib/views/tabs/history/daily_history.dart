import 'package:agua_diaria/functions/database.dart';
import 'package:agua_diaria/models/drink_history.dart';
import 'package:agua_diaria/models/drink_item.dart';
import 'package:agua_diaria/values/dicts.dart';
import 'package:agua_diaria/values/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyHistoryScreen extends StatefulWidget {
  final DateTime date;

  const DailyHistoryScreen({super.key, required this.date});

  @override
  State<DailyHistoryScreen> createState() => _DailyHistoryScreen();
}

class _DailyHistoryScreen extends State<DailyHistoryScreen> {
  late Future<List<DrinkHistory>> drinkHistoryFuture;

  @override
  void initState() {
    drinkHistoryFuture = getDrinkHistoryFromDate(widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FutureBuilder<List<DrinkHistory>>(
                future: drinkHistoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final drinkHistory = snapshot.data!;
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 24, right: 24),
                          child: Column(
                            children: [
                              Text(
                                '${widget.date.day.toString().padLeft(2, '0')} de ${ptBrMonths[widget.date.month - 1]} de ${widget.date.year.toString().padLeft(4, '0')}'
                                    .toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Expanded(
                                child: ListView.builder(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: drinkHistory.length,
                                    itemBuilder: (context, index) {
                                      final drinkHistoryItem =
                                          drinkHistory[index];
                                      final drinkItem = DrinkItem(
                                          drinkHistoryItem.drink,
                                          '${drinkHistoryItem.drink.toString().split('.')[1]}.svg');
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 24),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 24,
                                                      child: SvgPicture.asset(
                                                        drinkItem.path,
                                                        height: 24,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Text(drinkDict[
                                                                drinkItem.type]
                                                            ?.toLowerCase() ??
                                                        ''),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                    '${drinkHistoryItem.drinkAmount} ml'),
                                              ),
                                              Text(
                                                '${drinkHistoryItem.date.hour.toString().padLeft(2, '0')}:${drinkHistoryItem.date.minute.toString().padLeft(2, '0')}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                  onTap: () async {
                                                    final shouldExclude =
                                                        await showDialog<bool>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "exclusão"),
                                                          content: const Text(
                                                              "deseja excluir o item?"),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
                                                              },
                                                              child: const Text(
                                                                  'sim',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          14)),
                                                            ),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          false);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'não',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    if (shouldExclude == true) {
                                                      if (drinkHistoryItem.id !=
                                                          null) {
                                                        await deleteDrinkHistoryItem(
                                                            drinkHistoryItem
                                                                .id!);
                                                      }
                                                      setState(() {
                                                        drinkHistoryFuture =
                                                            getDrinkHistoryFromDate(
                                                                widget.date);
                                                      });
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        const BackButton()
                      ],
                    );
                  } else {
                    return const Center(
                      // TODO: mudar a cor do circulo
                      child: CircularProgressIndicator(
                        color: Color(0xFF3688D3),
                      ),
                    );
                  }
                })));
  }
}
