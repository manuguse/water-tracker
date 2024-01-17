import 'package:agua_diaria/models/drink_history.dart';
import 'package:agua_diaria/models/drink_item.dart';
import 'package:agua_diaria/values/dicts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddDrinkDialog extends StatelessWidget {
  final DrinkItem drinkItem;
  final drinkController = TextEditingController();

  AddDrinkDialog({super.key, required this.drinkItem});

  @override
  Widget build(BuildContext context) {
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
                        Text(
                          drinkDict[drinkItem.type]?.toUpperCase() ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
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
                      height: 20,
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
                                date: DateTime.now(),
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
