import 'package:agua_diaria/views/goal.dart';
import 'package:agua_diaria/views/history.dart';
import 'package:agua_diaria/views/settings.dart';
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
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: TabBar(controller: tabController, tabs: const [
              Tab(text: "diário"),
              Tab(text: "histórico"),
              Tab(text: "configurações"),
            ]),
          ),
        ),
        body: getTabBarPages());
  }

  Widget getTabBarPages() {
    return TabBarView(
        controller: tabController,
        children: const <Widget>[GoalScreen(), HistoryScreen(), Settings()]);
  }
}
