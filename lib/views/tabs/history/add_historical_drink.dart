import 'package:agua_diaria/models/drink_history.dart';
import 'package:agua_diaria/models/drink_item.dart';
import 'package:agua_diaria/values/dicts.dart';
import 'package:agua_diaria/values/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddHistoricalDrinkDialog extends StatefulWidget {
  const AddHistoricalDrinkDialog({super.key});

  @override
  State<AddHistoricalDrinkDialog> createState() =>
      _AddHistoricalDrinkDialogState();
}

class _AddHistoricalDrinkDialogState extends State<AddHistoricalDrinkDialog> {
  late Drink drink;
  late DateTime dateTime;
  final drinkController = TextEditingController();

  @override
  void initState() {
    drink = Drink.values[0];
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final drinkItem = DrinkItem(drink, '${drink.toString().split('.')[1]}.svg');
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: SvgPicture.asset(
                        drinkItem.path,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'bebida:',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // Text(
                        //   drinkDict[drinkItem.type]?.toUpperCase() ?? '',
                        //   style: const TextStyle(
                        //       fontWeight: FontWeight.bold, fontSize: 32),
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 1,
                        // ),
                        DropdownButton<Drink>(
                          value: drink,
                          // icon: const Icon(Icons.arrow_downward,
                          //     color: Color(0xFF020A0F)),
                          iconEnabledColor: const Color(0xFF020A0F),
                          elevation: 16,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Color(0xFF020A0F)),
                          underline: Container(
                            height: 4,
                            color: const Color(0xFF3688D3),
                          ),
                          onChanged: (Drink? value) {
                            if (value != null) {
                              setState(() {
                                drink = value;
                              });
                            }
                          },
                          selectedItemBuilder: (context) =>
                              Drink.values.map<Widget>((Drink value) {
                            return Text(
                              drinkDict[value]?.toUpperCase() ?? '',
                            );
                          }).toList(),
                          items: Drink.values
                              .map<DropdownMenuItem<Drink>>((Drink value) {
                            return DropdownMenuItem<Drink>(
                              value: value,
                              child: Text(
                                drinkDict[value]?.toLowerCase() ?? '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: Column(
                  children: [
                    const Text('quantidade tomada:'),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: drinkController,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('ml'),
                          ),
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
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final pickedDateTime = await showDatePicker(
                          context: context,
                          initialDate: dateTime,
                          firstDate: DateTime(1970, 1, 1),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDateTime != null) {
                          setState(() {
                            dateTime = pickedDateTime;
                          });
                        }
                      },
                      child: SizedBox( //TODO descobrir como deixar menos estatico o tamanho
                        width: 200,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFF3688D3), width: 2),
                              borderRadius: BorderRadius.circular(30)),
                          shadowColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.date_range_outlined,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().padLeft(4, '0')}',
                                    // style: const TextStyle(
                                    //   color: Colors.transparent,
                                    //   shadows: [
                                    //     Shadow(
                                    //         offset: Offset(0, -4), color: Colors.white)
                                    //   ],
                                    //   decoration: TextDecoration.underline,
                                    //   decorationColor: Colors.white,
                                    //   decorationThickness: 2,
                                    // ),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF3688D3)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: const BorderSide(
                                        color: Color(0xFF3688D3))))),
                        child: const Text(
                          "adicionar",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          final amount = int.tryParse(drinkController.text);
                          if (amount != null) {
                            final drinkHistory = DrinkHistory(
                                date: dateTime,
                                drinkAmount: amount,
                                drink: drinkItem.type);
                            await drinkHistory.saveOnDatabase();
                            if (context.mounted) {
                              Navigator.of(context).pop(true);
                            }
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: IconButton(
            icon: const Icon(
              Icons.close,
              size: 28,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        )
      ],
    );
  }
}
