import 'package:agua_diaria/models/goal_amount.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool darkMode = true;
  bool reminders = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final goalAmount = context.watch<GoalAmount>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Switch(
                  value: darkMode,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      darkMode = value;
                    });
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Text('modo noturno'),
              ]),
              Row(children: [
                Switch(
                  value: reminders,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      reminders = value;
                    });
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Text('lembretes'),
              ]),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text('hora de acordar'),
                          const SizedBox(height: 4,),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Center(child: Text('09:15')),
                              ))
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text('hora de dormir'),
                          const SizedBox(height: 4,),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Center(child: Text('23:45')),
                              ))
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('meta diária'),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text('${goalAmount.amount} ml')),
                        )),
                  )
                ],
                // TODO botar o text como variável
              ),
            ],
          ),
        ),
      ),
    );
  }
}
