import 'package:flutter/material.dart';
import 'package:varzish/screens/account_info/account_info.dart';
import 'package:varzish/screens/home/exercise/exercise.dart';
import 'package:varzish/screens/home/plan/my_plan.dart';
import 'package:varzish/screens/home/stats/stats.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(_selectedIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? "My Training Plan" : "My Stats",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context, builder: (context) => const AccountInfo());
            },
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: const [
            MyPlan(),
            Stats(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books_sharp), label: "My Plan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart_sharp), label: "Statistics"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
