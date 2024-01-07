import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool light = true;

  @override
  void initState() {
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
                  value: light,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      light = value;
                    });
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Text('modo noturno'),
              ]),
              Row(children: [
                Switch(
                  value: light,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      light = value;
                    });
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Text('lembretes'),
              ]),
              const SizedBox(height: 36),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('hora de acordar'),
                          Text('09:15'),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('hora de dormir'),
                          Text('23:45'),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('meta diária'), Text('3010 ml')],
                // TODO botar o text como variável
              ),
            ],
          ),
        ),
      ),
    );
  }
}
