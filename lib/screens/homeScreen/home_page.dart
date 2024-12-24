import 'package:flutter/material.dart';
import 'package:varzish/screens/homeScreen/plan_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Training Plan",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: PlanList()), //Card
        ],
      ),
    );
  }
}
