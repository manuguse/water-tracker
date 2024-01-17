import 'package:agua_diaria/views/tabs/goal/goal.dart';
import 'package:agua_diaria/views/tabs/history/history.dart';
import 'package:agua_diaria/views/tabs/settings/settings.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40), // here the desired height
          child: AppBar(
            flexibleSpace: SafeArea(
              child: TabBar(
                  onTap: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  physics: const BouncingScrollPhysics(),
                  controller: tabController,
                  indicatorColor: Colors.white,
                  tabs: const [
                    Tab(text: "diário"),
                    Tab(text: "histórico"),
                    Tab(text: "configurações"),
                  ]),
            ),
          ),
        ),
        body: getTabBarPages());
  }

  Widget getTabBarPages() {
    return TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: tabController,
        children: const <Widget>[
          GoalScreen(),
          HistoryScreen(),
          LoadSettings()
        ]);
  }
}
