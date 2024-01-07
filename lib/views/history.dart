import 'package:agua_diaria/functions/database.dart';
import 'package:agua_diaria/functions/drink_items.dart';
import 'package:agua_diaria/models/drink_history.dart';
import 'package:agua_diaria/models/drink_item.dart';
import 'package:agua_diaria/values/dicts.dart';
import 'package:agua_diaria/values/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final Future<Map<int, Map<DateTime, List<DrinkHistory>>>>
      drinkHistoryFuture;

  @override
  void initState() {
    drinkHistoryFuture = getDrinkHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FutureBuilder<Map<int, Map<DateTime, List<DrinkHistory>>>>(
                future: drinkHistoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final drinkHistory = snapshot.data!;
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 32, left: 24, right: 24),
                      child: Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 24),
                            physics: const BouncingScrollPhysics(),
                            itemCount: drinkHistory.length,
                            itemBuilder: (context, index) {
                              final year =
                                  drinkHistory.keys.toList()[index];
                              final drinkHistoryByYear =
                                  drinkHistory[year]!;
                              return Column(
                                children: [
                                  Text(
                                    year.toString().padLeft(4, '0'),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16,),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: drinkHistoryByYear.length,
                                      itemBuilder: (context, index) {
                                        final drinkHistoryDate =
                                            drinkHistoryByYear.keys
                                                .toList()[index];
                                        final drinkHistoryDateItems =
                                            drinkHistoryByYear[
                                                drinkHistoryDate]!;
                                        final drinkItemsByDrinkType =
                                            getDrinkItemsByDrinkType(
                                                drinkHistoryDateItems);

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // transformando o mês para string
                                            Text(
                                              '${drinkHistoryDate.day.toString().padLeft(2, '0')} de ${ptBrMonths[drinkHistoryDate.month - 1]}'
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            ListView.builder(
                                              itemCount:
                                                  drinkItemsByDrinkType
                                                      .length,
                                              itemBuilder:
                                                  (context, index) {
                                                final drinkType =
                                                    drinkItemsByDrinkType
                                                        .keys
                                                        .toList()[index];
                                                final drinkItems =
                                                    drinkItemsByDrinkType[
                                                        drinkType]!;

                                                final drinkItem = DrinkItem(
                                                    drinkType,
                                                    '${drinkType.toString().split('.')[1]}.svg');
                                                return Card(
                                                  shape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 16,
                                                            horizontal: 24),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 24,
                                                              child:
                                                                  SvgPicture
                                                                      .asset(
                                                                drinkItem
                                                                    .path,
                                                                height: 24,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 16,
                                                            ),
                                                            Text(drinkDict[drinkItem
                                                                        .type]
                                                                    ?.toLowerCase() ??
                                                                ''),
                                                          ],
                                                        ),
                                                        // total de cada bebida:
                                                        Text(
                                                            '${drinkItems.map((e) => e.drinkAmount).reduce((value, element) => value + element).toString()} ml'),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('total:'),
                                                // total do dia:
                                                Text(
                                                  '${drinkItemsByDrinkType.values.toList().map<int>((e) => e.map((e) => e.drinkAmount).reduce((value, element) => value + element)).reduce((value, element) => value + element).toString()} ml',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              );
                            }),
                      ),
                    );
                  } else {
                    return const Center(
                      // TODO: mudar a cor do circulo
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }
}
