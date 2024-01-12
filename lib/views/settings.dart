import 'package:agua_diaria/functions/shared_preferences.dart';
import 'package:agua_diaria/models/goal_amount.dart';
import 'package:agua_diaria/models/settings_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoadSettings extends StatefulWidget {
  const LoadSettings({super.key});

  @override
  State<LoadSettings> createState() => _LoadSettingsState();
}

class _LoadSettingsState extends State<LoadSettings> {
  late final Future<SettingsItemsToEdit> settingsItemsToEditFuture;

  Future<SettingsItemsToEdit> getSettingsItemsToEdit() async {
    final settingsItems = await getSettingsItems();
    final settingsItemsToEdit =
        SettingsItemsToEdit.fromSettingsItems(settingsItems);
    return settingsItemsToEdit;
  }

  @override
  void initState() {
    settingsItemsToEditFuture = getSettingsItemsToEdit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: FutureBuilder<SettingsItemsToEdit>(
          future: settingsItemsToEditFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Settings(settingsItemsToEdit: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class Settings extends StatefulWidget {
  final SettingsItemsToEdit settingsItemsToEdit;

  const Settings({super.key, required this.settingsItemsToEdit});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late final TextEditingController goalAmountController;

  @override
  void initState() {
    goalAmountController = TextEditingController(
        text: widget.settingsItemsToEdit.goalAmount.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Switch(
                  value: widget.settingsItemsToEdit.darkMode,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      widget.settingsItemsToEdit.darkMode = value;
                      setSharedPrefsBool('darkmode', value);
                    });
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Text('modo noturno'),
              ]),
              Row(children: [
                Switch(
                  value: widget.settingsItemsToEdit.reminders,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      widget.settingsItemsToEdit.reminders = value;
                      setSharedPrefsBool('reminders', value);
                    });
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Text('lembretes'),
              ]),
              if (widget.settingsItemsToEdit.reminders)
                Column(
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('hora de acordar'),
                            const SizedBox(
                              height: 4,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final timeOfDay = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        widget.settingsItemsToEdit.wakingTime,
                                    builder: (context, child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child ?? Container(),
                                      );
                                    });
                                if (timeOfDay != null) {
                                  setState(() {
                                    widget.settingsItemsToEdit.wakingTime =
                                        timeOfDay;
                                  });
                                  await setTimeOfDay(timeOfDay, 'waking');
                                }
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Center(
                                        child: Text(
                                            '${widget.settingsItemsToEdit.wakingTime.hour.toString().padLeft(2, '0')}:${widget.settingsItemsToEdit.wakingTime.minute.toString().padLeft(2, '0')}')),
                                  )),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text('hora de dormir'),
                            const SizedBox(
                              height: 4,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final timeOfDay = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        widget.settingsItemsToEdit.sleepingTime,
                                    builder: (context, child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child ?? Container(),
                                      );
                                    });
                                if (timeOfDay != null) {
                                  setState(() {
                                    widget.settingsItemsToEdit.wakingTime =
                                        timeOfDay;
                                  });
                                  await setTimeOfDay(timeOfDay, 'sleeping');
                                }
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Center(
                                        child: Text(
                                            '${widget.settingsItemsToEdit.sleepingTime.hour.toString().padLeft(2, '0')}:${widget.settingsItemsToEdit.sleepingTime.minute.toString().padLeft(2, '0')}')),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('meta diária'),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                      width: 150,
                      height: 35,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                            controller: goalAmountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) async {
                              final goalAmount =
                                  int.tryParse(goalAmountController.text);
                              if (goalAmount != null) {
                                await setSharedPrefsInt('goalAmount', goalAmount);
                                if (mounted) {
                                  context.read<GoalAmount>().amount = goalAmount;
                                }
                              }
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                contentPadding: const EdgeInsets.all(24),
                                fillColor: Colors.white,
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.only(right: 12),
                                  child: Text('ml'),
                                ),
                                suffixIconConstraints: const BoxConstraints(
                                    maxHeight: double.infinity))),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
